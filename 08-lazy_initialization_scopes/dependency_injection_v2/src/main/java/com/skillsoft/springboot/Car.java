package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Scope("prototype")
@Component
public class Car {

    private final Engine engine;
    private final Transmission transmission;

    @Autowired
    public Car(@Qualifier("v8Engine") Engine engine, Transmission transmission) {
        System.out.println("Constructing car with engine " + engine.toString() +
                " and transmission " + transmission.toString());

        this.engine = engine;
        this.transmission = transmission;
    }

    public Engine getEngine() {
        return engine;
    }

    public Transmission getTransmission() {
        return transmission;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}