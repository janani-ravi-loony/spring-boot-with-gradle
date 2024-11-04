######################################## 
demo-06-DependencyInjection
########################################

# Set up a new project (dependency_injection_starter)

dependency_injection

# Set up the build.gradle file

plugins {
    id 'java'
    id 'org.springframework.boot' version '3.3.4'
    id 'io.spring.dependency-management' version '1.1.6'
}

group = 'com.skillsoft.springboot'
version = '1.0-SNAPSHOT'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

test {
    useJUnitPlatform()
}

# v1

# These classes are already set up - let's add the annotations to enable dependency injection

# First let's look at each of the classes in turn

Engine.java
Car.java
CarApplication.java
CarConfig.java


# Engine.java (no annotations)

package com.skillsoft.springboot;

public class Engine {
    private final String type;

    public Engine(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "Engine{" +
                "type=" + type +
                '}';
    }
}

# Car.java

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Car {

    private final Engine engine;

    // Constructor-based Dependency Injection
    @Autowired
    public Car(Engine engine) {
        this.engine = engine;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString());
    }
}

# CarConfig.java

package com.skillsoft.springboot;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CarConfig {

    @Bean
    public Engine engine() {
        return new Engine("V8 Engine");
    }
}

# Rename the Main.java file to CarApplication.java

package com.skillsoft.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CarApplication implements CommandLineRunner {

    private final Car car;

    @Autowired
    public CarApplication(Car car) {
        this.car = car;
    }

    public static void main(String[] args) {
        SpringApplication.run(CarApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        car.drive();
    }
}


# Run the CarApplication.java file and show the result

# Try and remove one of the annotations on any of the injected classes

e.g. the @Bean annotation

# Run the CarApplication, it will fail

########################################

# Dependencies are singleton objects and they are injected based on type

# Let's add a new transmission dependency to the car

# Create a new class Transmission.java

package com.skillsoft.springboot;

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
                "model=" + model + '}';
    }
}


# Update the CarConfig.java file to set up Transmission as a bean as well


@Configuration
public class CarConfig {

    @Bean
    public Engine engine() {
        return new Engine("V8 Engine");
    }

    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}

# Update the Car,java file

@Component
public class Car {

    private final Engine engine;
    private final Transmission transmission;

    // Constructor-based Dependency Injection for both Engine and Transmission
    @Autowired
    public Car(Engine engine, Transmission transmission) {
        this.engine = engine;
        this.transmission = transmission;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}

# Go to the CarApplication.java file

# No change here, just run the code

# It should work fine!

############################################

# One Bean can depend on another (v2)

# We've already seen how the Car bean depends on the Engine and Transmission bean. 

# We can have the Transmission bean depend on the Engine bean 

# When beans depend on each other this is known as "bean dependency resolution"

# Update Transmission.java

public class Transmission {
    private final String model;
    private final Engine engine;  

    public Transmission(String model, Engine engine) {
        this.model = model;
        this.engine = engine;
    }

    public String getModel() {
        return model;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model=" + model +
                ", engine=" + engine +
                "}";
    }
}


# Update CarConfig.java


@Configuration
public class CarConfig {

    @Bean
    public Engine engine() {
        return new Engine("V8 Engine");
    }

    @Bean
    public Transmission transmission(Engine engine) {
        return new Transmission("Automatic Transmission", engine);
    }
}

# Go to the CarApplication.java file

# Run the application and show that it works


############################################
# Field dependency injection (v3)


# Engine.java (no change)

public class Engine {
    private final String type;

    public Engine(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "Engine{" +
                "type=" + type +
                '}';
    }
}

# Transmission.java

import org.springframework.beans.factory.annotation.Autowired;

public class Transmission {
    private final String model;

    @Autowired
    private Engine engine;  // Field-based dependency injection

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
                ", engine=" + engine +
                "}";
    }
}

# CarConfig.java 


@Configuration
public class CarConfig {

    @Bean
    public Engine engine() {
        return new Engine("V8 Engine");
    }

    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}

# Car.java


@Component
public class Car {

    @Autowired
    private Engine engine;

    @Autowired
    private Transmission transmission;

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}

# CarApplication.java (no change)

# Run the code and show that everything works as before

###################################
#### Setter-based dependency injection (v4)

# Transmission.java

public class Transmission {
    private final String model;
    private Engine engine;

    public Transmission(String model) {
        this.model = model;
    }

    @Autowired
    public void setEngine(Engine engine) {
        this.engine = engine;
    }

    public String getModel() {
        return model;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model='" + model +
                ", engine=" + engine +
                "}";
    }
}

# Car.java

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


# Everything else remains the same

# Run and show

##########################################
##### Injection based on name using qualifiers (v5)

# Transmission.java

package com.skillsoft.springboot;

public class Transmission {
    private final String model;
    private final Engine engine;

    public Transmission(String model,Engine engine) {
        this.model = model;
        this.engine = engine;
    }

    public Engine getEngine() {
        return engine;
    }

    @Override
    public String toString() {
        return "Transmission{" +
                "model=" + model +
                ", engine=" + engine +
                '}';
    }
}

# CarConfig.java


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CarConfig {

    @Bean(name = "v8Engine")
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Bean(name = "v6Engine")
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Bean
    public Transmission transmission(@Qualifier("v8Engine") Engine engine) {
        return new Transmission("Automatic Transmission", engine);
    }
}

# Car.java

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

# No changes to the other classes

# Just run and show

# In CarConfig.java change the qualifier for the engine to "v6"

# Show that the Car is not constructed because of our check

# In Car.java change the engine to "v6" and now things should work










