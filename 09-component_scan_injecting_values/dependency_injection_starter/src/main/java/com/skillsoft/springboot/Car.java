package com.skillsoft.springboot;

import com.skillsoft.springboot.core.Engine;
import com.skillsoft.springboot.core.Transmission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

public class Car {

    private final Engine engine;
    private final Transmission transmission;

    @Autowired
    public Car(@Qualifier("v8Engine") Engine engine, Transmission transmission) {
        this.engine = engine;
        this.transmission = transmission;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}