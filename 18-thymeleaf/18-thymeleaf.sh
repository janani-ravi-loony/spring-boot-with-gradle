######################################## 
demo-18-Thymeleaf 
########################################

# Thymeleaf is a modern Java-based server-side template engine used for rendering dynamic HTML, XML, and other content in Spring Boot applications. It allows developers to integrate dynamic data into templates, offering clean and maintainable code that works in both browsers and server environments. 

# Set up the thymeleaf_starter project and show the following files

# Show the dependencies
build.gradle

# Thymeleaf is for templating, Spring MVC for running the web app


# Under src/resources/templates
index.html


# Show the file
SimpleController.java



# Show the file
Main.java

# Nothing new here

# Run the code and on the browser go to

http://localhost:8080/

----------------------

# SimpleController.java

    return "indexasd";

# Run and show the error

# Come back and change the message

        model.addAttribute("message", "Hello, Thymeleaf - this is cool!");

# Change the attribute

        model.addAttribute("text", "Hello, Thymeleaf - this is cool!");

# The HTML will display the fallback text

-------------------------------------------
# index.html

# Comment this out

<!--<html xmlns:th="http://www.thymeleaf.org">-->

# Things still work, as this is not strictly required
# The xmlns:th="http://www.thymeleaf.org" declaration is mainly useful for XML-based tools (like XML validators) to recognize and validate the th: attributes. However, in the context of regular HTML documents, browsers don't need this declaration to interpret the page.


########################################
# Let's set up CSS for this simple page (v1)

# Under resources/ create

static/css/styles.css

body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
}

h1 {
    color: #2c3e50;
    text-align: center;
    padding: 20px;
}


# Update index.html

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Hello Thymeleaf</title>
    <link th:href="@{/css/styles.css}" rel="stylesheet">
</head>
<body>
    <h1 th:text="${message}">Placeholder Text</h1>
</body>
</html>


# Run and show


########################################
# Exploring Thymeleaf variables (v2)

# SimpleController.java

@Controller
public class SimpleController {

    @GetMapping("/")
    public String hello(Model model) {
        model.addAttribute("name", "John Doe");
        model.addAttribute("age", 30);
        model.addAttribute("currentTimestamp", LocalDateTime.now());
        model.addAttribute("rawHtml", "<b>This is bold text</b>");

        return "index";
    }
}

# Under src/main/resources set up

messages.properties

# Add this

subtitle=Internationalization in Thymeleaf
greeting=Welcome to Thymeleaf, {0}!
currentTimeMessage=The current time is {0}.


# index.html

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Hello Thymeleaf</title>
    <link th:href="@{/css/styles.css}" rel="stylesheet">
</head>
<body>

<!-- Using ${} to access model variables -->
<h1 th:text="'Welcome, ' + ${name} + '!'">Welcome!</h1>
<p th:text="'You are ' + ${age} + ' years old.'">Age Placeholder</p>
<p th:text="'Current time: ' + ${currentTimestamp}">Timestamp Placeholder</p>

<!-- Using th:utext for raw HTML content -->
<p th:utext="${rawHtml}">Raw HTML will appear here</p>


<h1 th:text="#{subtitle}">Subtitle Placeholder</h1>

<!-- Using #{greeting} with arguments to replace {0} in the message -->
<h3 th:text="#{greeting(${name})}">Welcome!</h3>

<!-- Using #{currentTimeMessage} with arguments to replace {1} in the message -->
<p th:text="#{currentTimeMessage(${currentTimestamp})}">Timestamp Placeholder</p>

</body>
</html>


########################################
# Conditions and loops (v3)

# Create a new package under springboot/

model

# Create a class

Car.java

# Set up the code

package com.skillsoft.springboot.model;

public class Car {
    private final String name;
    private final String fuelType;
    private final int year;

    public Car(String name, String fuelType, int year) {
        this.name = name;
        this.fuelType = fuelType;
        this.year = year;
    }

    public String getName() {
        return name;
    }

    public String getFuelType() {
        return fuelType;
    }

    public int getYear() {
        return year;
    }
}


# Update SimpleController.java

package com.skillsoft.springboot.controller;

import com.skillsoft.springboot.model.Car;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;
import java.util.List;

@Controller
public class SimpleController {

    @GetMapping("/cars")
    public String showCars(Model model) {
        List<Car> cars = Arrays.asList(
                new Car("Tesla Model 3", "Electric", 2022),
                new Car("Ford Mustang", "Gasoline", 2020),
                new Car("Chevrolet Camaro", "Gasoline", 2021)
        );

        model.addAttribute("cars", cars);
        model.addAttribute("isLoggedIn", false);

        return "index";
    }
}

# Update index.html

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>List of Cars</title>
    <link th:href="@{/css/styles.css}" rel="stylesheet">
</head>
<body>

<h1>Available Cars</h1>

<!-- Loop through the list of cars -->
<ul>
    <li th:each="car : ${cars}">
        <strong th:text="${car.name}">Car Name</strong> (Year: <span th:text="${car.year}">2022</span>) -
        <span th:text="${car.fuelType}">Fuel Type</span>

        <!-- Conditional: show 'Edit' button only if the user is logged in -->
        <button th:if="${isLoggedIn}" th:text="'Edit ' + ${car.name}">Edit</button>
    </li>
</ul>

<!-- Show a message if the user is not logged in -->
<p th:unless="${isLoggedIn}">You need to log in to edit car details.</p>

</body>
</html>


# Thymeleaf uses JavaBeans-style access to retrieve data from objects. This means that it relies on public getter methods to access the properties of an object.

# In Thymeleaf, when you access ${car.name}, the template engine looks for a public method called getName() in the Car class.
# Similarly, ${car.fuelType} refers to the method getFuelType() and ${car.year} refers to getYear().

# Run and show

----------------------------------------------------

# Things to try

# Change isLoggedIn to true/false

# Run and show how the UI changes

# In Car.java comment out one of the public getters

//
//    public int getYear() {
//        return year;
//    }

# Run and show the error
























