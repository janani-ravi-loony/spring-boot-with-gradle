package com.skillsoft.springboot.service;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.model.Project;
import com.skillsoft.springboot.repository.EmployeeRepository;
import com.skillsoft.springboot.repository.ProjectRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
}

