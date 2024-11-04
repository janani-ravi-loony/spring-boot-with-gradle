package com.skillsoft.springboot;

import com.skillsoft.springboot.core.Engine;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.*;

@Configuration
@EnableAutoConfiguration
@ComponentScan
public class CarApplication implements CommandLineRunner {

    private static ApplicationContext applicationContext;

    @Bean(name = "testEngine")
    public Engine testEngine() {
        return new Engine("Test Engine");
    }

    public static void main(String[] args) {
        applicationContext = SpringApplication.run(CarApplication.class, args);
        checkBeansPresence(
                "v8Engine", "v6Engine", "transmission", "GPS", "stereo", "car",
                "testEngine", "carApplication");

    }

    private static void checkBeansPresence(String... beans) {
        for (String beanName : beans) {
            System.out.println("Is " + beanName + " in ApplicationContext: " +
                    applicationContext.containsBean(beanName));
        }
    }

    @Override
    public void run(String... args) throws Exception {
        // Do nothing
    }
}