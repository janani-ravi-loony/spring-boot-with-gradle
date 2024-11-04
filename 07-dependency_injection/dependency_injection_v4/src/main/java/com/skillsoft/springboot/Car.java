package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Car {

    private Engine engine;
    private Transmission transmission;

    @Autowired
    public void setEngine(Engine engine) {
        this.engine = engine;
    }

    @Autowired
    public void setTransmission(Transmission transmission) {
        this.transmission = transmission;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}
