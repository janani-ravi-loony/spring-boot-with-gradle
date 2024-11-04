package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;
import java.util.Objects;


@SpringBootApplication
public class Main {

    @Autowired
    private EmployeeRepository employeeRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @PostConstruct
    public void init() {
        Employee emp1 = new Employee(
                "Alice Johnson", "HR Manager", 68000, "Human Resources");
        Employee emp2 = new Employee(
                "Bob Williams", "Marketing Specialist", 54000, "Marketing");
        Employee emp3 = new Employee(
                "Charlie Brown", "Software Engineer", 92000, "IT");
        Employee emp4 = new Employee(
                "Diana Evans", "Financial Analyst", 78000, "Finance");
//        Employee emp4 = new Employee(
//                "Diana Evans", "Financial Analystasdasdasdasdasdasdasdasdasdasdasdadas", 78000, "Finance");

        employeeRepository.save(emp1);
        employeeRepository.save(emp2);
        employeeRepository.save(emp3);
        employeeRepository.save(emp4);

        Iterable<Employee> employees = employeeRepository.findAll();
        employees.forEach(System.out::println);

        Employee employeeById = employeeRepository.findById(emp1.getId()).orElse(null);
        if (employeeById != null) {
            System.out.println("Employee found by ID: " + employeeById);
        }

        Objects.requireNonNull(employeeById).setSalary(70000);
        employeeRepository.save(employeeById);
        System.out.println("Updated employee: " + employeeRepository.findById(emp1.getId()).orElse(null));

        employeeRepository.deleteById(emp2.getId());
        System.out.println("Deleted employee with ID: " + emp2.getId());

        Employee deletedEmployee = employeeRepository.findById(emp2.getId()).orElse(null);
        if (deletedEmployee == null) {
            System.out.println("Employee with ID " + emp2.getId() + " was successfully deleted.");
        }
    }
}
