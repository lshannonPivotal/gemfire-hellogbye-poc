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

@Controller
public class SimpleController {
	
	@Resource(name="segments")
	Region<String,Segment[]> region;
	
	@RequestMapping("/function")
    public String function(Model model) {
    	GemfireOnRegionFunctionTemplate template = new GemfireOnRegionFunctionTemplate(region);
		long start = System.nanoTime();
		Iterable<String> result = template.execute(DataLoadFunction.ID, "/home/ubuntu/cluster/gemfire-ubuntu-package/data/");
		System.out.println("Here are the function results");
		if (result != null) {
			for (Object d : result) {
				System.out.println("Function returned: "  + d);
			}
		}
		System.out.println("Done Data Load");
		long end = System.nanoTime();
		long elapsedTime = end - start;
		model.addAttribute("time",TimeUnit.SECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS));
		model.addAttribute("results",result);
    	return "function";
    }
	
	@RequestMapping("/get")
	public String get(Model model) {
		String key = "2015-07-26-LAX-JFK";
		long start = System.nanoTime();
		Segment[] segment = region.get(key);
		long end = System.nanoTime();
		long elapsedTime = end - start;
		model.addAttribute("time",TimeUnit.SECONDS.convert(elapsedTime, TimeUnit.NANOSECONDS));
		model.addAttribute("key",key);
		StringBuffer sb = new StringBuffer();
		for (Segment s : segment) {
			sb.append(s.toString());
		}
		model.addAttribute("values",sb.toString());
		return "get";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		model.addAttribute("isEmpty", region.isEmpty());
		model.addAttribute("keys", region.keySet().size());
		return "list";
	}
	
    
    @RequestMapping("/home")
    public String home() {
    	return "home";
    }

}
