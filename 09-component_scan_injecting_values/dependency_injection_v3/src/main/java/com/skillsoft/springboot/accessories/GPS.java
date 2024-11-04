package com.skillsoft.springboot.accessories;

import org.springframework.stereotype.Component;

@Component
public class GPS {
    private final String brand;

    public GPS() {
        this.brand = "Garmin";
    }

    public String getBrand() {
        return brand;
    }

    @Override
    public String toString() {
        return "GPS{" +
                "brand='" + brand +
                "}";
    }
}