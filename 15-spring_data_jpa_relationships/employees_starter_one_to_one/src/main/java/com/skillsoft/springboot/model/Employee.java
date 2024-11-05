package com.skillsoft.springboot.model;

import jakarta.persistence.*;

@Entity
@Table(name = "employees")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String title;

    private int salary;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "performance_stats_id", referencedColumnName = "id")
    private PerformanceStats performanceStats;

    public Employee() {
    }

    public Employee(String name, String title, int salary) {
        this.name = name;
        this.title = title;
        this.salary = salary;
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

    public void setPerformanceStats(PerformanceStats performanceStats) {
        this.performanceStats = performanceStats;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", name=" + name +
                ", title=" + title +
                ", salary=" + salary +
                ", performanceStats=" + performanceStats.toString() +
                '}';
    }
}
