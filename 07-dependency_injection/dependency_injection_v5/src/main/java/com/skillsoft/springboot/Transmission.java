package com.skillsoft.springboot;

public class Transmission {
    private final String model;
    private final Engine engine;

    public Transmission(String model,Engine engine) {
        this.model = model;
        this.engine = engine;
    }

    public Engine getEngine() {
        return engine;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model=" + model +
                ", engine=" + engine +
                '}';
    }
}