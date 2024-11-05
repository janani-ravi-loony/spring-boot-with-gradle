package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.model.Skill;
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
        Employee employee1 = new Employee();
        employee1.setName("John Doe");
        employee1.setTitle("Java Developer");
        employee1.setSalary(200000);

        Skill skill1 = new Skill();
        skill1.setSkillName("Java");

        Skill skill2 = new Skill();
        skill2.setSkillName("Spring Boot");

        // Set the employee for each skill
        skill1.setEmployee(employee1);
        skill2.setEmployee(employee1);

        // Add skills to the employee
        List<Skill> skills = new ArrayList<>();
        skills.add(skill1);
        skills.add(skill2);
        employee1.setSkills(skills);

        employeeService.saveEmployeeWithSkills(employee1);

        // Employee 2
        Employee employee2 = new Employee();
        employee2.setName("Alice Smith");
        employee2.setTitle("Python Developer");
        employee2.setSalary(150000);

        skill1 = new Skill();
        skill1.setSkillName("Python - advanced");

        skill2 = new Skill();
        skill2.setSkillName("Pandas - beginner");

        Skill skill3 = new Skill();
        skill3.setSkillName("SQLAlchemy - beginner");

        // Set the employee for each skill
        skill1.setEmployee(employee2);
        skill2.setEmployee(employee2);
        skill3.setEmployee(employee2);

        // Add skills to the employee
        skills = new ArrayList<>();
        skills.add(skill1);
        skills.add(skill2);
        skills.add(skill3);
        employee2.setSkills(skills);

        employeeService.saveEmployeeWithSkills(employee2);

        System.out.println("Employees and Skills saved successfully.");

        System.out.println("********************************** Load employee");

        Optional<Employee> joeOptional = employeeService.findEmployeeById(1L);

        if (joeOptional.isPresent()) {
            Employee joe = joeOptional.get();

            System.out.println("********************************** Load skills");

            System.out.println(joe.getSkills());
        }


    }
}
