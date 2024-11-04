package com.skillsoft.springboot;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;

@Configuration
public class CarConfig {

    @Lazy
    @Bean(name = "v8Engine")  // First Engine bean named "v8Engine"
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Lazy
    @Bean(name = "v6Engine")  // Second Engine bean named "v6Engine"
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Lazy
    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}