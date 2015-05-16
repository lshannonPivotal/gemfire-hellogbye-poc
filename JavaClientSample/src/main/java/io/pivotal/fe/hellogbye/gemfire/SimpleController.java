package io.pivotal.fe.hellogbye.gemfire;

import io.pivotal.fe.hellogbye.gemfire.loader.DataLoadFunction;
import io.pivotal.fe.hellogbye.gemfire.model.Segment;

import javax.annotation.Resource;

import org.springframework.data.gemfire.function.execution.GemfireOnRegionFunctionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gemstone.gemfire.cache.Region;

@Controller
public class SimpleController {
	
	@Resource(name="segments")
	Region<String,Segment[]> region;
	
	@RequestMapping("/function")
    public String function() {
    	GemfireOnRegionFunctionTemplate template = new GemfireOnRegionFunctionTemplate(region);
		Iterable<String> result = template.execute(DataLoadFunction.ID);
		System.out.println("Here are the function results");
		if (result != null) {
			for (Object d : result) {
				System.out.println("Function returned: "  + d);
			}
		}
		System.out.println("Done Data Load");
    	return "Done";
    }
	
	@RequestMapping("/get")
	public String get() {
		Segment[] segment = region.get("2015-07-26-LAX-JFK");
		return segment.toString();
	}
	
    
    @RequestMapping("/home")
    public String home() {
    	return "Enter the url '/function' to run the function. Enter the url '/get' to get the key:2015-07-26-LAX-JFK";
    }

}
