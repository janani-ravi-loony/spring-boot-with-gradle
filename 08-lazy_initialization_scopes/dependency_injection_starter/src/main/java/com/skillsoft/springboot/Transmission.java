package com.skillsoft.springboot;

public class Transmission {
    private final String model;

    public Transmission(String model) {
        System.out.println("Constructing transmission with model: " + model);
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
