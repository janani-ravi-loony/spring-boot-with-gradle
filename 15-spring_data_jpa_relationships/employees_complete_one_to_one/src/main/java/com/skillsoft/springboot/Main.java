package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.model.PerformanceStats;
import com.skillsoft.springboot.service.EmployeeService;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

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
        Employee employee1 = new Employee();
        employee1.setName("John Doe");
        employee1.setTitle("VP");
        employee1.setSalary(200000);

        PerformanceStats stats1 = new PerformanceStats();
        stats1.setYearlyRating(5);
        stats1.setTotalProjects(12);
        stats1.setHoursWorked(2000);

        employeeService.saveEmployeeWithStats(employee1, stats1);

        // Employee 2
        Employee employee2 = new Employee();
        employee2.setName("Alice Smith");
        employee2.setTitle("Senior VP");
        employee2.setSalary(300000);

        PerformanceStats stats2 = new PerformanceStats();
        stats2.setYearlyRating(4);
        stats2.setTotalProjects(10);
        stats2.setHoursWorked(1800);

        employeeService.saveEmployeeWithStats(employee2, stats2);

        // Employee 3
        Employee employee3 = new Employee();
        employee3.setName("Bob Johnson");
        employee3.setTitle("Manager");
        employee3.setSalary(100000);

        PerformanceStats stats3 = new PerformanceStats();
        stats3.setYearlyRating(3);
        stats3.setTotalProjects(8);
        stats3.setHoursWorked(1500);

        employeeService.saveEmployeeWithStats(employee3, stats3);

        System.out.println("Employees and Performance Stats saved successfully.");

        // Access performanceStats by ID
        Optional<PerformanceStats> stats = employeeService.findPerformanceStatsById(2L);
        if (stats.isPresent()) {
            PerformanceStats performanceStats = stats.get();

            Employee employee = performanceStats.getEmployee();
            System.out.println("********");
            System.out.println(employee);
        }

        // Delete an employee
        employeeService.deleteEmployeeById(1L);

        // Try and delete performance stats
        employeeService.deletePerformanceStatsById(2L);

    }
}
