package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.model.Project;
import com.skillsoft.springboot.service.EmployeeService;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@SpringBootApplication
public class Main {

    @Autowired
    private EmployeeService employeeService;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @PostConstruct
    public void init() {
        // Employee 1
        Employee employee1 = new Employee("John Doe", "Java Developer", 200000);

        // Create Projects
        Project projectA = new Project("Project A");
        Project projectB = new Project("Project B");

        // Set the projects for the employee
        employee1.setProjects(List.of(projectA, projectB));

        // NOTE: We do not need to set the employees on the project since the Employee
        // is the owning side of the relationship and manages the join table

        // Save the employee and the projects (due to cascade)
        employeeService.saveEmployeeWithProjects(employee1);

        // Employee 2
        Employee employee2 = new Employee("Alice Smith", "Python Developer", 150000);

        // Create Projects
        Project projectX = new Project("Project X");

        // Set the projects for the employee
        employee2.setProjects(List.of(projectX));

        // Save the employee and the projects (due to cascade)
        employeeService.saveEmployeeWithProjects(employee2);

        System.out.println("Employees and Projects saved successfully.");

        System.out.println("********************************** Load employee");

        List<Project> projectsJohn = employeeService.findProjectsByEmployeeId(1L);

        System.out.println(projectsJohn);

        // Add an employee to a project
        projectX = employeeService.findProjectById(3L).orElseThrow();
        employeeService.addProjectToEmployee(1L, projectX);
    }
}
