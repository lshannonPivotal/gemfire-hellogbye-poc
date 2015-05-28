package io.pivotal.fe.hellogbye.gemfire.loader;

import io.pivotal.fe.hellogbye.gemfire.model.Segment;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import com.gemstone.gemfire.LogWriter;
import com.gemstone.gemfire.cache.Cache;
import com.gemstone.gemfire.cache.CacheFactory;
import com.gemstone.gemfire.cache.Declarable;
import com.gemstone.gemfire.cache.Region;
import com.gemstone.gemfire.cache.execute.FunctionAdapter;
import com.gemstone.gemfire.cache.execute.FunctionContext;
import com.gemstone.gemfire.cache.execute.RegionFunctionContext;
import com.gemstone.gemfire.cache.partition.PartitionRegionHelper;
import com.gemstone.gemfire.distributed.DistributedMember;
import com.google.gson.Gson;

/**
 * This is a function to read HelloGBye JSON files into Gemfire
 * It deletes each file as its loaded
 * 
 * @author lshannon
 *
 */
public class DataLoadFunction extends FunctionAdapter implements Declarable {
	
	public static final String ID = DataLoadFunction.class.getSimpleName();

	private LogWriter logger;
	private DistributedMember member;
	private String backUpDirectory;

	private static final long serialVersionUID = -7759261808685094980L;

	@Override
	public void execute(FunctionContext context) {
		System.out.println("Got the context: " + context);
		System.out.println("Arguments are null: " + (context.getArguments() == null) != null ? true : false);
		if (context.getArguments() == null) {
			System.out.println("Must Provide the location of the data folder when executing the function.");
			context.getResultSender().lastResult("Must Provide the location of the data folder when executing the function.");
		}
		Cache cache = CacheFactory.getAnyInstance();
		this.member = cache.getDistributedSystem().getDistributedMember();
		logger = cache.getDistributedSystem().getLogWriter();
		Object[] arg = (Object[]) context.getArguments();
		backUpDirectory = (String) arg[0];
		RegionFunctionContext rfc = (RegionFunctionContext) context;
		String loadingSummary = null;
		try {
			loadingSummary = loadSegments(rfc.getDataSet());
			context.getResultSender().lastResult(loadingSummary);
		}
		catch (Exception e) {
			context.getResultSender().lastResult(e);
		}
	}

	/**
	 * This function passes through the folder of JSON files. If the key, which
	 * is the name of the file, would be a primary on this node its loaded by
	 * this member into the cluster. Not primary entries are ignored, they will
	 * be picked up by another member
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String loadSegments(@SuppressWarnings("rawtypes") Region region) {
		logger.info("Started loading segments from: " + backUpDirectory);
		// summary of the loading process
		long startTime = 0, endTime = 0;
		int totalSegments = 0, loadedSegments = 0, skippedSegments = 0;
		startTime = System.currentTimeMillis();
		BufferedReader br = null;
		File segments = new File(backUpDirectory);
		logger.info("Loading From: " + backUpDirectory + " " + segments.list().length + " file to process");
		String[] files = segments.list();
		Gson gson = new Gson();
		for (int i = 0; i < files.length; i++) {
			if (files[i].endsWith(".json")) {
				try {
					//name of the file is the key
					String key = files[i].substring(0, files[i].indexOf("."));
					//this is an entry, but may not be one for this server
					totalSegments++;
					//this will return the member that would be the primary copy for this data, if its this
					//member running the function, we will do the put
					//otherwise its skipped
					if (this.member.equals(PartitionRegionHelper.getPrimaryMemberForKey(region, key))) {
						//read the file
						br = new BufferedReader(new FileReader(backUpDirectory + files[i]));
						//get an array of Segment objects http://stackoverflow.com/questions/3763937/gson-and-deserializing-an-array-of-objects-with-arrays-in-it
						Segment[] segmentValue = gson.fromJson(br,Segment[].class);
						//put the value in
						logger.info("Putting: " + segmentValue.toString());
						region.put(key, segmentValue);
						logger.info("Put complete");
						loadedSegments++;
						//delete the file after its been loaded
						//Files.delete(new File(backUpDirectory + files[i]).toPath());
					} else {
						skippedSegments++;
					}
				} 
				catch (IOException e) {
					this.logger.error(e);
				}
				//clean up
				finally {
					if (br != null) {
						try {
							br.close();
						} catch (IOException e) {
							this.logger.error(e);
						}
					}
				}
			}
		}
		endTime = System.currentTimeMillis();
		//return the summary
		DataLoadFunction.LoadingSummary loadingSummary = new LoadingSummary(member.toString(), startTime, endTime, totalSegments, skippedSegments, loadedSegments);
		logger.info("Loading Complete: " + loadingSummary.toString());
		return loadingSummary.toString();
	}

	@Override
	public String getId() {
		return ID;
	}

	@Override
	public boolean hasResult() {
		return true;
	}

	@Override
	public boolean isHA() {
		return true;
	}

	@Override
	public boolean optimizeForWrite() {
		return true;
	}

	@Override
	public void init(Properties arg0) {
	}

	/**
	 * Convenience class for storing the results of a segment load operation
	 * @author lshannon
	 *
	 */
	class LoadingSummary {
		
		private String memberName;
		private long startTime;
		private long endTime;
		private int totalSegments;
		private int segmentsSkipped;
		private int segmentsLoaded;

		public LoadingSummary(String memberName, long startTime, long endTime, int totalSegments, int segmentsSkipped, int segmentsLoaded) {
			this.memberName = memberName;
			this.startTime = startTime;
			this.endTime = endTime;
			this.totalSegments = totalSegments;
			this.segmentsSkipped = segmentsSkipped;
			this.segmentsLoaded = segmentsLoaded;
		}
		
		public String getMemberName() {
			return memberName;
		}

		public long getStartTime() {
			return startTime;
		}

		public long getEndTime() {
			return endTime;
		}

		public int getTotalSegments() {
			return totalSegments;
		}

		public int getSegmentsSkipped() {
			return segmentsSkipped;
		}

		public int getSegmentsLoaded() {
			return segmentsLoaded;
		}


		@Override
		public String toString() {
			return "LoadingSummary [memberName=" + memberName + ", startTime="
					+ startTime + ", endTime=" + endTime + ", totalSegments="
					+ totalSegments + ", segmentsSkipped=" + segmentsSkipped
					+ ", segmentsLoaded=" + segmentsLoaded + "]";
		}
	}

}
