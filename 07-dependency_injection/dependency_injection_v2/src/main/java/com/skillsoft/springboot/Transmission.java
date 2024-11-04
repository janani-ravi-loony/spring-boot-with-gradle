package com.skillsoft.springboot;

public class Transmission {
    private final String model;
    private final Engine engine;  // Transmission depends on Engine

    public Transmission(String model, Engine engine) {
        this.model = model;
        this.engine = engine;
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