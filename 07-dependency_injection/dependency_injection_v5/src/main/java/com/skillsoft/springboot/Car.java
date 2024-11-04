package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class Car {

    private final Engine engine;
    private final Transmission transmission;

    // Constructor-based injection with Qualifier for both Engine and Transmission
    @Autowired
    public Car(@Qualifier("v8Engine") Engine engine, @Qualifier("transmission") Transmission transmission) {
        this.engine = engine;
        this.transmission = transmission;

        if (!this.engine.equals(this.transmission.getEngine())) {
            throw new IllegalArgumentException("Engine in Car does not match Engine in Transmission!");
        }
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}