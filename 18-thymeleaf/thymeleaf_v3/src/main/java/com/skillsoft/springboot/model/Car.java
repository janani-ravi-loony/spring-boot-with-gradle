package com.skillsoft.springboot.model;

public class Car {
    private final String name;
    private final String fuelType;
    private final int year;

    public Car(String name, String fuelType, int year) {
        this.name = name;
        this.fuelType = fuelType;
        this.year = year;
    }

    public String getName() {
        return name;
    }

    public String getFuelType() {
        return fuelType;
    }

    public int getYear() {
        return year;
    }
}
