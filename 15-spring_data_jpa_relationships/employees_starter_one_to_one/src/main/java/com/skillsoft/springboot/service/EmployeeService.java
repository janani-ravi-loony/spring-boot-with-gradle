package com.skillsoft.springboot.service;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.model.PerformanceStats;
import com.skillsoft.springboot.repository.EmployeeRepository;
import com.skillsoft.springboot.repository.PerformanceStatsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private PerformanceStatsRepository performanceStatsRepository;

    public void saveEmployeeWithStats(Employee employee, PerformanceStats performanceStats) {
        // Set the bidirectional relationship
        employee.setPerformanceStats(performanceStats);
        performanceStats.setEmployee(employee);

        // Save both entities, Employee will manage the relationship and cascade the stats
        // Cascading saves the performance stats
        employeeRepository.save(employee);
    }

    public Optional<Employee> findEmployeeById(Long id) {
        return employeeRepository.findById(id);
    }

    public Optional<PerformanceStats> findPerformanceStatsById(Long id) {
        return performanceStatsRepository.findById(id);
    }
}
