package com.skillsoft.springboot.core;

public class Transmission {
    private final String model;

    public Transmission(String model) {
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