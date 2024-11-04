######################################## 
demo-03-SpringInitializr 
########################################

# => Go to https://start.spring.io/

=> Launch Spring Initializr and choose the following options
	project: Gradle Groovy
	Language: Java 
	Spring Boot: 3.3.4
	Group: com.skillsoft.springboot
	Artifact: booksrestapi
	Name: booksrestapi
	Description: Simple demo showing an in-memory API server
	Packing: Jar 
	Java: 17

# -- Click on add dependencies to the top right
# -- Show the various options available
# -- Choose only one dependency: Spring Web

# Click Generate Project 

# A zip file will be downloaded. 

# Place zip in IdeaProjects and unzip

booksrestapi

# Import this into IntelliJ as a new Gradle project

# File -> Open -> IdeaProjects -> booksrestapi

# Show the build.gradle file

build.gradle

# Rename the main application file to 

BooksApplication.java

# Just run the application (we have not set up any controllers yet)

# Go to the browser

http://localhost:8080/

# This will show an error because we haven't mapped requests to any pages



















