package io.pivotal.fe.hellogbye.gemfire.loader;

import io.pivotal.fe.hellogbye.gemfire.model.Segment;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.data.gemfire.function.execution.GemfireOnRegionFunctionTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import com.gemstone.gemfire.cache.Cache;
import com.gemstone.gemfire.cache.Region;

@ContextConfiguration("/applicationContext-gemfire.xml")
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = DataLoaderFunctionApplication.class)
public class DataLoaderFunctionApplicationTestsSpring {
	
	static Log log = LogFactory.getLog(DataLoaderFunctionApplicationTestsSpring.class);
	
	@Autowired
	private Cache gemfireCache;
	
	@Resource(name="segments")
	Region<String,Segment[]> region;

	@Test
	public void test() {
		log.debug("Starting Data Load");
		GemfireOnRegionFunctionTemplate template = new GemfireOnRegionFunctionTemplate(region);
		Iterable<String> result = template.execute(DataLoadFunction.ID);
		log.debug("Here are the function results");
		if (result != null) {
			for (Object d : result) {
				log.debug("Function returned: "  + d);
			}
		}
		log.debug("Done Data Load");
		Segment[] value = region.get("2015-07-26-LAX-JFK");
		Assert.notNull(value);
		for (int i= 0; i < value.length; i++) {
			System.out.println("************** REGION VALUE: " + value[i]);
		}
		region.close();
	}

}
