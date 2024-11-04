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

    // Use @PostConstruct to execute logic after the application context is loaded
    @PostConstruct
    public void init() {

        employeeRepository.save(new Employee(
                "John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee(
                "Jane Smith", "Jane Smith", 75000, "IT"));

        employeeRepository.findAll().forEach(employee ->
                System.out.println(employee.toString())
        );

    }}
