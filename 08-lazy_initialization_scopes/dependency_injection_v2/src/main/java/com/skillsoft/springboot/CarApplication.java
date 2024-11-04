package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CarApplication implements CommandLineRunner {

    @Autowired
    private Car car1;

    @Autowired
    private Car car2;

    public static void main(String[] args) {
        SpringApplication.run(CarApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        System.out.println("Are car1 and car2 the same? " + (car1 == car2));

        System.out.println("Are car1 and car2 engines the same? " +
                (car1.getEngine() == car2.getEngine()));

        System.out.println("Are car1 and car2 transmissions the same? " +
                (car1.getTransmission() == car2.getTransmission()));
    }
}