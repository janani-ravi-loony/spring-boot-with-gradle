package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;


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
                "Alice Johnson", "HR Manager", 68000,
                "Human Resources");

        Employee emp2 = new Employee(
                "Bob Williams", "Marketing Specialist", 54000,
                "Marketing");

        Employee emp3 = new Employee(
                "Charlie Brown", "Software Engineer", 92000,
                "IT");

        Employee emp4 = new Employee(
                "Diana Evans", "Financial Analyst", 78000,
                "Finance");

        employeeRepository.save(emp1);
        employeeRepository.save(emp2);
        employeeRepository.save(emp3);
        employeeRepository.save(emp4);

        List<Employee> employees = employeeRepository.findAll();
        employees.forEach(emp -> System.out.println(emp.toString()));

        // Derived query methods
        System.out.println("*******Employees named Bob Williams");
        List<Employee> employeesNamedBob = employeeRepository.findByName("Bob Williams");
        employeesNamedBob.forEach(emp -> System.out.println(emp.toString()));

        System.out.println("*******Employees in IT");
        List<Employee> itEmployees = employeeRepository.findByDepartment("IT");
        itEmployees.forEach(emp -> System.out.println(emp.toString()));

        System.out.println("*******Employees with salary > 80000");
        List<Employee> higherSalaryEmployees = employeeRepository.findBySalaryGreaterThan(80000);
        higherSalaryEmployees.forEach(emp -> System.out.println(emp.toString()));

        // JPQL
        System.out.println("*******Employees with name containing Diana");
        List<Employee> dianaEmployees = employeeRepository.findByNameContaining("Diana");
        dianaEmployees.forEach(emp -> System.out.println(emp.toString()));

        System.out.println("*******Employees with IT salary above 50000");
        List<Employee> itHighSalaryEmployees = employeeRepository.findBySalaryAndDepartment(
                50000, "IT");
        itHighSalaryEmployees.forEach(emp -> System.out.println(emp.toString()));

        // Updates
        System.out.println("********Updating salary of Alice Johnson");
        employeeRepository.updateEmployeeSalaryById(emp1.getId(), 75000);

        System.out.println("********Updating department of Bob Williams");
        employeeRepository.updateEmployeeDepartmentByName("Bob Williams", "Sales");

        // Native SQL
        System.out.println("*******Employees in finance");
        List<Employee> financeEmployees = employeeRepository.findByDepartmentNative("Finance");
        financeEmployees.forEach(emp -> System.out.println(emp.toString()));

        System.out.println("*******Employees with salary > 80000 in IT");
        List<Employee> higherSalaryITEmployees = employeeRepository.findBySalaryAndDepartmentNative(
                80000, "IT");
        higherSalaryITEmployees.forEach(emp -> System.out.println(emp.toString()));
    }
}
