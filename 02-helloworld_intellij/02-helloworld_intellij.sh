######################################## 
demo-02-HelloWorldFromIntelliJ
########################################

# Download IntelliJ from here

https://www.jetbrains.com/idea/download/?section=mac

# Click on "New Project" in IntelliJ

hello_world

# Will be under ~/IdeaProjects

# Choose 

Gradle

# If you work in IntelliJ IDEA, you don't need to install Gradle separately, IntelliJ IDEA does it for you.

# Pick JDK 17

# Advanced -> Group ID

com.skillsoft.springboot

# Artifact ID

hello_world

# Create the project

# Update the build.gradle file as follows

plugins {
    id 'java'
    id 'org.springframework.boot' version '3.3.4'
}

apply plugin: 'io.spring.dependency-management'

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
    implementation 'org.springframework.boot:spring-boot-starter-web'
}

# Under src/main/java rename the Main.java file to App.java

package com.skillsoft.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class App {

    @RequestMapping("/")
    String home() {
        return "Hello World from Spring Boot!";
    }

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}


# Note that things are in red, the dependencies are not resolved

# On the right there should be a gradle icon, click on that

Refresh

# Now the dependencies have been downloaded and have been resolved

# Run the application from within IntelliJ 

# On the browser go to
http://localhost:8080/

##################################
# v1

# Create a new class for the controller

# Under com.skillsoft.springboot create package

controller

# Create class

HelloController.java

# Here is the code for the class

package com.skillsoft.springboot.controller;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "This is the main page";
    }

    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public String welcome() {
        return "Welcome to Spring Boot!";
    }

    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public String hello() {
        return "Hello Spring Boot!";
    }
}

# Change the code in App.java

package com.skillsoft.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {

    public static void main(String[] args) {

        SpringApplication.run(App.class, args);
    }
}



# Run the code

# Go to the browser

http://localhost:8080/
http://localhost:8080/hello
http://localhost:8080/welcome

# Everything should work

#########################################

# Running on the Jetty server rather than the Tomcat server

# In the build.gradle file exclude the Tomcat server dependency and include the jetty dependency

dependencies {
    // Include Spring Boot Web Starter but exclude Tomcat
    implementation('org.springframework.boot:spring-boot-starter-web') {
        exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
    }

    // Add Jetty as the embedded server
    implementation 'org.springframework.boot:spring-boot-starter-jetty'
}

# Run the app and show that we are running on the Jetty server. 

# All pages should still work on the browser

http://localhost:8080/
http://localhost:8080/hello
http://localhost:8080/welcome











