package io.pivotal.fe.hellogbye.gemfire;

import javax.annotation.Resource;

import org.springframework.data.gemfire.function.execution.GemfireOnRegionFunctionTemplate;
import org.springframework.data.gemfire.function.execution.GemfireOnRegionOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gemstone.gemfire.cache.Region;

@Controller
public class SimpleController {
	
	@Resource(name = "segments")
	Region<?,?> segments;
	
	@RequestMapping("/function")
    public String function() {
    	GemfireOnRegionOperations template = new GemfireOnRegionFunctionTemplate(segments);
    	String result = template.executeAndExtract("DataLoadFunction");
    	return result;
    }
    
    @RequestMapping("/")
    public String home() {
    	return "Enter the url '/function' to run the function. Enter the url '/get' to get the key:2015-07-26-LAX-JFK";
    }

}
