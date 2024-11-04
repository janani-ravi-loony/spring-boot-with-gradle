package com.skillsoft.springboot.model;

import jakarta.persistence.*;

@Entity
@Table(
    name = "employees",
    schema = "organization",
    uniqueConstraints = @UniqueConstraint(columnNames = {"name"}),
    indexes = @Index(columnList = "dept_name")
)
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "employee_name", nullable = false, length = 100, unique = true)
    private String name;

    @Column(name = "job_title", length = 50)
    private String title;

    @Column(name = "salary", nullable = false)
    private int salary;

    @Column(name = "dept_name", length = 100)
    private String department;

    public Employee() {

    }

    public Employee(String name, String title, int salary, String department) {
        this.name = name;
        this.title = title;
        this.salary = salary;
        this.department = department;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", name=" + name +
                ", title=" + title +
                ", salary=" + salary +
                ", department=" + department +
                '}';
    }
}
