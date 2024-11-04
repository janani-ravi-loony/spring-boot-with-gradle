package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class Main {

    @Autowired
    private EmployeeRepository employeeRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @PostConstruct
    public void init() {
        // Insert employees
        employeeRepository.save(new Employee(
                "John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee(
                "Jane Smith", "Engineer", 75000, "IT"));
        employeeRepository.save(new Employee(
                "Alice Johnson", "Manager", 90000, "Finance"));
        employeeRepository.save(new Employee(
                "Bob Brown", "Developer", 80000, "IT"));

        // Retrieve and print all employees
        System.out.println("Employees in the database:");
        employeeRepository.findAll().forEach(employee -> System.out.println(employee.toString()));

        // Access and display an entity by ID
        Long employeeId = 3L; // ID of the employee to retrieve
        System.out.println("\nRetrieve employee with ID 3:");
        employeeRepository.findById(employeeId).ifPresent(employee -> System.out.println(employee.toString()));

        // Update an entity
        Long bobId = 4L;
        employeeRepository.findById(bobId).ifPresent(bob -> {
            bob.setTitle("Senior Developer");
            bob.setSalary(85000);
            employeeRepository.save(bob);
            System.out.println("\nUpdated employee with ID 4:");
            System.out.println(bob.toString());
        });

        // Delete an entity by ID
        Long deleteId = 2L;
        employeeRepository.deleteById(deleteId);
        System.out.println("\nDeleted employee with ID 2");

        // Retrieve and print all employees after update and delete
        System.out.println("\nEmployees in the database after update and delete:");
        employeeRepository.findAll().forEach(employee -> System.out.println(employee.toString()));
    }
}
