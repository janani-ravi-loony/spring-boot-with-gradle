package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.Optional;


@SpringBootApplication
public class Main {

    @Autowired
    private EmployeeRepository employeeRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    // Use @PostConstruct to execute logic after the application context is loaded
    @PostConstruct
    public void init() {

        employeeRepository.save(new Employee("John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee("Jane Smith", "Engineer", 75000, "IT"));
        employeeRepository.save(new Employee("Alice Johnson", "Manager", 90000, "Finance"));
        employeeRepository.save(new Employee("Bob Brown", "Developer", 80000, "IT"));

        employeeRepository.findAll().forEach(employee ->
                System.out.println(employee.toString())
        );

        // Retrieve 2 employees by ID and print
        System.out.println("Retrieving employees by ID:");
        Optional<Employee> employee1 = employeeRepository.findById(2L);
        employee1.ifPresent(e -> System.out.println("Employee 2: " + e.toString()));

        Optional<Employee> employee2 = employeeRepository.findById(4L);
        employee2.ifPresent(e -> System.out.println("Employee 4: " + e.toString()));

        // Update one of the employees
        Employee bob = employeeRepository.findById(4L).orElseThrow(() ->
                new RuntimeException("Employee not found"));
        bob.setTitle("Senior Developer");
        bob.setSalary(85000);
        employeeRepository.update(bob);
        System.out.println("Updated Employee 4: " + bob.toString());

        // Delete one employee (Delete Jane Smith)
        employeeRepository.delete(2L);
        System.out.println("Deleted Employee with ID 2");

        // Fetch and print all remaining employees
        System.out.println("Remaining employees after update and delete:");
        employeeRepository.findAll().forEach(employee -> System.out.println(employee.toString()));
    }}
