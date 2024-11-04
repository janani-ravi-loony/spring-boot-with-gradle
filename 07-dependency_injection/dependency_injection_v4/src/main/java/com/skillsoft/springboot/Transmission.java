package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;

public class Transmission {
    private final String model;
    private Engine engine;

    public Transmission(String model) {
        this.model = model;
    }

    @Autowired
    public void setEngine(Engine engine) {
        this.engine = engine;
    }

    public String getModel() {
        return model;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model='" + model +
                ", engine=" + engine +
                "}";
    }
}