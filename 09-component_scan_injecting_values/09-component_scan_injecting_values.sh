######################################## 
demo-09-ComponentScanAndInjectingValues 
########################################

# Start with the dependency_injection_starter

# Show the classes inside core/

Engine.java
Transmission.java
CarConfig.java

# Show the classes inside accessories/

GPS.java
Stereo.java

# Show classes in the top-level package

Car.java
CarApplication.java

# Run the code and show the output

Is v8Engine in ApplicationContext: true
Is v6Engine in ApplicationContext: false # No @Bean annotation
Is transmission in ApplicationContext: true
Is GPS in ApplicationContext: false # No @Component
Is stereo in ApplicationContext: false # No @Component
Is car in ApplicationContext: false # No @Component
Is testEngine in ApplicationContext: true
Is carApplication in ApplicationContext: true



# Run and show that all beans are automatically scanned and registered

# Comment out the @ComponentScan and run - you'll find that no beans have been registered from the subpackages

# The only bean registered is the one from the CarApplication class

---------------------------------------------------------------
# V1

# Now add the annotations to register the following classes and methods

GPS
Stereo
Car
v6Engine()

# Run the code again (all beans registered)

Is v8Engine in ApplicationContext: true
Is v6Engine in ApplicationContext: true
Is transmission in ApplicationContext: true
Is GPS in ApplicationContext: true
Is stereo in ApplicationContext: true
Is car in ApplicationContext: true
Is testEngine in ApplicationContext: true
Is carApplication in ApplicationContext: true

---------------------------------------------------------------

# Now let's explicitly specify what packages we want to scan

# Change this

@ComponentScan(basePackages = "com.skillsoft.springboot.core")
public class CarApplication implements CommandLineRunner {

# Run the code

Is v8Engine in ApplicationContext: true
Is v6Engine in ApplicationContext: true
Is transmission in ApplicationContext: true
Is GPS in ApplicationContext: false
Is stereo in ApplicationContext: false
Is car in ApplicationContext: false
Is testEngine in ApplicationContext: true
Is carApplication in ApplicationContext: true

# Note that the "accessories" package is not in the application context, we have excluded it from the scan

# If CarConfig.java had not been in the "core" package the engine and transmission would also not be in the context

---------------------------------------------------------------

# Include multiple packages
@ComponentScan(basePackages = {
        "com.skillsoft.springboot.core", "com.skillsoft.springboot.accessories"})

# Run and show

Is v8Engine in ApplicationContext: true
Is v6Engine in ApplicationContext: true
Is transmission in ApplicationContext: true
Is GPS in ApplicationContext: true
Is stereo in ApplicationContext: true
Is car in ApplicationContext: false
Is testEngine in ApplicationContext: true
Is carApplication in ApplicationContext: true

---------------------------------------------------------------

# Set up an exclude filter
@ComponentScan(
        excludeFilters = @ComponentScan.Filter(type = FilterType.REGEX,
        pattern = "com.skillsoft.springboot.accessories.*")
)

# Run and show

Is v8Engine in ApplicationContext: true
Is v6Engine in ApplicationContext: true
Is transmission in ApplicationContext: true
Is GPS in ApplicationContext: false
Is stereo in ApplicationContext: false
Is car in ApplicationContext: true
Is testEngine in ApplicationContext: true
Is carApplication in ApplicationContext: true

########################################
### Injecting properties using the @Value annotation

# Let's delete the CarConfig.java file (we will use the @Component annotation for engine and transmission)

# Under resources/ set up application.properties

engine.type=V12 Engine
transmission.type=Manual Transmission

# Update Engine.java (note the @Component annotation)

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Engine {
    private final String type;

    public Engine(@Value("${engine.type}") String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "Engine{" +
                "type='" + type +
                "}";
    }
}

# Update Transmission.java (note the @Component annotation)

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Transmission {
    private final String model;

    public Transmission(@Value("${transmission.type}") String model) {
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

# Update Car.java


import com.skillsoft.springboot.core.Engine;
import com.skillsoft.springboot.core.Transmission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Car {

    private final Engine engine;
    private final Transmission transmission;

    @Autowired
    public Car(Engine engine, Transmission transmission) {
        this.engine = engine;
        this.transmission = transmission;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}

# Update CarApplication.java

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CarApplication implements CommandLineRunner {

    @Autowired
    private Car car;

    public static void main(String[] args) {
        SpringApplication.run(CarApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        car.drive();
    }
}


# Run and show that the properties are injected from the file!

# Go to the application.properties and change the properties

# Run and show that the new properties are picked up!






























