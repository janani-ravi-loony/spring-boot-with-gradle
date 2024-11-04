package com.skillsoft.springboot.accessories;

import org.springframework.stereotype.Component;

public class Stereo {
    private final String brand;

    public Stereo() {
        this.brand = "Sony";
    }

    public String getBrand() {
        return brand;
    }

    @Override
    public String toString() {
        return "Stereo{" +
                "brand='" + brand +
                "}";
    }
}