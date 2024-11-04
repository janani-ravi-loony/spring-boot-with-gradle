package com.skillsoft.springboot.core;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Transmission {
    private final String model;

    public Transmission(@Value("${transmission.type}") String model) {
        this.model = model;
    }

    public String getModel() {
        return model;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model='" + model +
                "}";
    }
}