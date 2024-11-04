package com.skillsoft.springboot.core;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Engine {
    private final String type;

    public Engine(@Value("${engine.type}") String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "Engine{" +
                "type=" + type +
                '}';
    }
}