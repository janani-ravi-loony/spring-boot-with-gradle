package com.skillsoft.springboot;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CarConfig {

    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}
