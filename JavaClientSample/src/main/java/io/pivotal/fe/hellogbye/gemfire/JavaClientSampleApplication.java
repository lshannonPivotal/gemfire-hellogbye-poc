package io.pivotal.fe.hellogbye.gemfire;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;


@SpringBootApplication
@ImportResource("classpath:cache-config.xml")
public class JavaClientSampleApplication {

    public static void main(String[] args) {
        SpringApplication.run(JavaClientSampleApplication.class, args);
    }
    
    
}
