package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CarConfig {

    @Bean(name = "v8Engine")
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Bean(name = "v6Engine")
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Bean
    public Transmission transmission(@Qualifier("v8Engine") Engine engine) {
        return new Transmission("Automatic Transmission", engine);
    }
}