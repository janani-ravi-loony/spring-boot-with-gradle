######################################## 
demo-01-SpringBootHelloWorld 
########################################

# Java Version: Spring Boot 3 requires Java 17 as the minimum version. Ensure your environment is configured with at least Java 17 or higher for compatibility with Spring Boot 3.

# Gradle Version: Spring Boot 3 is compatible with Gradle 7.5 or higher. It's recommended to use the latest stable version of Gradle to ensure full feature support and compatibility.


# On the terminal
java --version

# Download Java here
https://www.oracle.com/in/java/technologies/downloads/#java17

# Check the gradle version
gradle --version

# Steps to install gradle here
https://gradle.org/install/

mkdir springboot

cd springboot

mkdir hello_world

cd hello_world

---------------------------------

# Inside the hello_world directory set up a build.gradle file
# Use Sublimetext

# Drag the hello_world directory to Sublimetext and use that to set up the structure

plugins {
	id 'java'
	id 'org.springframework.boot' version '3.3.4'
}

apply plugin: 'io.spring.dependency-management'

group = 'com.example'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '17'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}

repositories {
	mavenCentral()
}

dependencies {
}

# Terminal
gradle dependencies

# There should be no dependencies

# Add this to build.gradle

dependencies {
	implementation 'org.springframework.boot:spring-boot-starter-web'
}



# Now run this again
gradle dependencies

# Notice that a whole number of dependencies have been added including the Tomcat web server and Spring Boot itself.

mkdir src
cd src

mkdir main
cd main

mkdir java
cd java

# Set up an App.java file here here

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

# Now go to the terminal

cd ~/springboot/hello_world

# Run the web application
gradle bootRun

# Note the messages - we're running on the Tomcat web server on port 8080


# On the browser go to
http://localhost:8080/

# Look at the terminal window you should see messages to the dispatcher servlet

# Make sure you kill the application on the terminal (in preparation for the next demo)
Ctrl + C









































