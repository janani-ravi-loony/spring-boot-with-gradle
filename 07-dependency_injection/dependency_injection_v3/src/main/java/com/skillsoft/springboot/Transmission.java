package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;

public class Transmission {
    private final String model;

    @Autowired
    private Engine engine;  // Field-based dependency injection

    public Transmission(String model) {
        this.model = model;
    }

    public String getModel() {
        return model;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model=" + model +
                ", engine=" + engine +
                "}";
    }
}