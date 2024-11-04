package com.skillsoft.springboot;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Configuration
public class CarConfig {

    @Scope("prototype")
    @Lazy
    @Bean(name = "v8Engine")
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Scope("prototype")
    @Lazy
    @Bean(name = "v6Engine")
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Scope("prototype")
    @Lazy
    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}