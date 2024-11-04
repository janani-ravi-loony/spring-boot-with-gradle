package com.skillsoft.springboot;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CarConfig {

    @Bean
    public Engine engine() {
        return new Engine("V8 Engine");
    }

    @Bean
    public Transmission transmission(Engine engine) {
        return new Transmission("Automatic Transmission");
    }
}
