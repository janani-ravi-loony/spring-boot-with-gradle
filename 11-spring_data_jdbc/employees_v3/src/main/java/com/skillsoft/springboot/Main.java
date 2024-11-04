package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;
import java.util.Optional;


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
        employeeRepository.save(new Employee("John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee("Jane Smith", "Engineer", 75000, "IT"));
        employeeRepository.save(new Employee("Alice Johnson", "Manager", 90000, "Finance"));
        employeeRepository.save(new Employee("Bob Brown", "Developer", 80000, "IT"));

        List<Employee> itEmployees = employeeRepository.findByDepartment("IT");
        System.out.println("\nEmployees in the IT department:");
        itEmployees.forEach(employee -> System.out.println(employee.toString()));

        List<Employee> highSalaryEmployees = employeeRepository.findEmployeesWithSalaryGreaterThan(70000);
        System.out.println("\nEmployees with salary greater than 70,000:");
        highSalaryEmployees.forEach(employee -> System.out.println(employee.toString()));

        List<Employee> managers = employeeRepository.findByTitle("Manager");
        System.out.println("\nEmployees with the title 'Manager':");
        managers.forEach(employee -> System.out.println(employee.toString()));

        List<Employee> salaryRangeEmployees = employeeRepository.findEmployeesBySalaryRange(60000, 85000);
        System.out.println("\nEmployees with salary between 60,000 and 85,000:");
        salaryRangeEmployees.forEach(employee -> System.out.println(employee.toString()));

        // Increase salary range by percentage
        employeeRepository.increaseSalaryByPercentage(10);

        Iterable<Employee> employees = employeeRepository.findAll();
        System.out.println("\nAll employees with increased salary:");
        employees.forEach(employee -> System.out.println(employee.toString()));

        // Update employee title by id
        employeeRepository.updateEmployeeTitleById(2L, "CTO");
        Optional<Employee> employee = employeeRepository.findById(2L);
        System.out.println("Employee with increased salary: " + employee.get());

    }

}
