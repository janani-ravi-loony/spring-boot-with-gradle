package com.skillsoft.springboot.model;

import jakarta.persistence.*;

@Entity
public class PerformanceStats {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int yearlyRating;
    private int totalProjects;
    private double hoursWorked;

    @OneToOne(mappedBy = "performanceStats")
    private Employee employee;

    public PerformanceStats() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getYearlyRating() {
        return yearlyRating;
    }

    public void setYearlyRating(int yearlyRating) {
        this.yearlyRating = yearlyRating;
    }

    public int getTotalProjects() {
        return totalProjects;
    }

    public void setTotalProjects(int totalProjects) {
        this.totalProjects = totalProjects;
    }

    public double getHoursWorked() {
        return hoursWorked;
    }

    public void setHoursWorked(double hoursWorked) {
        this.hoursWorked = hoursWorked;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    @Override
    public String toString() {
        return "PerformanceStats {" +
                "yearlyRating=" + yearlyRating +
                ", totalProjects=" + totalProjects +
                ", hoursWorked=" + hoursWorked +
                '}';
    }
}
