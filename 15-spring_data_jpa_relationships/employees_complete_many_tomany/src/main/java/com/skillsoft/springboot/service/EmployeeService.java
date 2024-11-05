package com.skillsoft.springboot.service;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.model.Project;
import com.skillsoft.springboot.repository.EmployeeRepository;
import com.skillsoft.springboot.repository.ProjectRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private ProjectRepository projectRepository;

    // Save an Employee with a list of Projects
    public void saveEmployeeWithProjects(Employee employee) {
        employeeRepository.save(employee);
    }

    public Optional<Employee> findEmployeeById(Long id) {
        return employeeRepository.findById(id);
    }

    public Optional<Project> findProjectById(Long id) {
        return projectRepository.findById(id);
    }

    @Transactional
    public List<Project> findProjectsByEmployeeId(Long id) {
        Optional<Employee> employeeOptional = employeeRepository.findEmployeeWithProjectsById(id);

        if (employeeOptional.isPresent()) {
            Employee employee = employeeOptional.get();
            return employee.getProjects(); // Projects are eagerly loaded in the query
        } else {
            return List.of(); // Return an empty list if employee is not found
        }
    }


    @Transactional
    public void addProjectToEmployee(Long employeeId, Project project) {
        Employee employee = employeeRepository.findById(employeeId).orElseThrow();

        employee.getProjects().add(project);

        saveEmployeeWithProjects(employee);
    }
}

