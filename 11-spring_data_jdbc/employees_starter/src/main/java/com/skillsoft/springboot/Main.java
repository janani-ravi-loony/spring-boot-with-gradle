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
    }
}
