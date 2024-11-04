######################################## 
demo-07-LazyInitializationAndScopes
########################################

# Set up once again with the dependency_injection_starter

########################################
### Lazy initialization (v1)

# Simplify the setup so transmission no longer depends on engine

# Also we have print() statements in all constructors

# Engine.java

public class Engine {
    private final String type;

    public Engine(String type) {
        System.out.println("Constructing engine with type: " + type);
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

public class Transmission {
    private final String model;

    public Transmission(String model) {
        System.out.println("Constructing transmission with model: " + model);
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

# CarConfig.java

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CarConfig {

    @Bean(name = "v8Engine")  // First Engine bean named "v8Engine"
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Bean(name = "v6Engine")  // Second Engine bean named "v6Engine"
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}

# Car.java


@Component
public class Car {

    private final Engine engine;
    private final Transmission transmission;

    // Constructor-based injection with Qualifier for Engine
    @Autowired
    public Car(@Qualifier("v8Engine") Engine engine, Transmission transmission) {
        System.out.println("Constructing car with engine " + engine.toString() +
                " and transmission " + transmission.toString());

        this.engine = engine;
        this.transmission = transmission;
    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
    }
}


# Car.java depends on both Engine and Transmission

# Run and show the order of instantiations (both engines and the transmission are initialized)

------------------------------------

# Now in order to show lazy initialization - let us have Car only depend on Engine

# Car.java

@Component
public class Car {

    private final Engine engine;
//    private final Transmission transmission;

//    @Autowired
//    public Car(@Qualifier("v8Engine") Engine engine, Transmission transmission) {
//        System.out.println("Constructing car with engine " + engine.toString() +
//                " and transmission " + transmission.toString());
//
//        this.engine = engine;
//        this.transmission = transmission;
//    }

    @Autowired
    public Car(@Qualifier("v8Engine") Engine engine) {
        System.out.println("Constructing car with engine " + engine.toString());

        this.engine = engine;
    }

//    public void drive() {
//        System.out.println("Car is driving with " + engine.toString() + " and " + transmission.toString());
//    }

    public void drive() {
        System.out.println("Car is driving with " + engine.toString());
    }
}

# First run the code and show that again both engines and the transmission are initailized

------------------------------------
# Lazy initialization

# @Lazy on Beans: The @Lazy annotation ensures that the Engine and Transmission beans are only created when they are first accessed (in this case, when Car calls their methods).

# Lazy Initialization: By default, Spring initializes all beans at startup. Using @Lazy defers this initialization until the bean is actually needed, which can improve startup performance in large applications.

# CarConfig.java

@Configuration
public class CarConfig {

    @Lazy
    @Bean(name = "v8Engine")  // First Engine bean named "v8Engine"
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Lazy
    @Bean(name = "v6Engine")  // Second Engine bean named "v6Engine"
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Lazy
    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}

# Run and show

##########################################
#### Scopes

# Let's prove that the default scope is the singleton scope

# Car.java (add getters)

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

# CarApplication.java
# Check for whether car, engine, and transmission instances are the same

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

# Run and show that every instance is a singleton instance

# Now go to CarConfig.java and explicitly specify Singleton instance

import org.springframework.context.annotation.Scope;

@Configuration
public class CarConfig {

    @Scope("singleton")
    @Lazy
    @Bean(name = "v8Engine")
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Scope("singleton")
    @Lazy
    @Bean(name = "v6Engine")
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Scope("singleton")
    @Lazy
    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}

# Add the scope to Car.java as well

@Scope("singleton")
@Component
public class Car {


# Now run again and show we get the same result

-------------------------------

# Now let's change the scope to prototype

# For Car.java

@Scope("prototype")
@Component
public class Car {

# Can run and show that engine and transmissions are singletons and a new car instance is created for each injection

# Now change to prototype scope here as well

# CarConfig.java

@Configuration
public class CarConfig {

    @Scope("prototype")
    @Lazy
    @Bean(name = "v8Engine")
    public Engine v8Engine() {
        return new Engine("V8 Engine");
    }

    @Scope("prototype")
    @Lazy
    @Bean(name = "v6Engine")
    public Engine v6Engine() {
        return new Engine("V6 Engine");
    }

    @Scope("prototype")
    @Lazy
    @Bean
    public Transmission transmission() {
        return new Transmission("Automatic Transmission");
    }
}


# Now run the code and show the instances are not the same
# You can see from the constructor print statements multiple cars, engines, and transmissions are constructed

































