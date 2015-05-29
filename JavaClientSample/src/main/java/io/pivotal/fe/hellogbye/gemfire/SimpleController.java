package io.pivotal.fe.hellogbye.gemfire;

import io.pivotal.fe.hellogbye.gemfire.loader.DataLoadFunction;
import io.pivotal.fe.hellogbye.gemfire.model.Segment;

import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.springframework.data.gemfire.function.execution.GemfireOnRegionFunctionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gemstone.gemfire.cache.Region;
import com.gemstone.gemfire.pdx.PdxInstance;

@Controller
public class SimpleController {
	
	@Resource(name="segments")
	Region<String,Segment[]> region;
	
	@RequestMapping("/function")
    public String function(Model model) {
    	GemfireOnRegionFunctionTemplate template = new GemfireOnRegionFunctionTemplate(region);
		long start = System.nanoTime();
		Iterable<String> result = template.execute(DataLoadFunction.ID, "/home/ubuntu/cluster/gemfire-ubuntu-package/data/");
		long end = System.nanoTime();
		long elapsedTime = end - start;
		model.addAttribute("time",TimeUnit.SECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS));
		model.addAttribute("results",result);
    		return "function";
    }
	
	@RequestMapping("/get")
	public String get(Model model) {
		String key = "2015-07-26-LAX-JFK1";
		long start = System.nanoTime();
		Segment[] segment = toObject(region.get(key), Segment[].class);
		long end = System.nanoTime();
		long elapsedTime = end - start;
		model.addAttribute("time",TimeUnit.SECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS));
		model.addAttribute("key",key);
		StringBuffer sb = new StringBuffer();
		for (int i= 0; i < segment.length; i++) {
			sb.append(segment[i]);
		}
		model.addAttribute("values",segment);
		model.addAttribute("records",segment.length);
		return "get";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		model.addAttribute("keys", region.keySetOnServer().size());
		return "list";
	}
	
    
    @RequestMapping("/home")
    public String home() {
    		return "home";
    }
    
    @SuppressWarnings("unchecked")
	private <T> T toObject(final Object object, final Class<T> clazz) {
		if (object instanceof PdxInstance) {
			return (T) ((PdxInstance) object).getObject();
		}
		return (T) object;
	}


}
