package com.skillsoft.springboot.service;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    public void saveEmployeeWithSkills(Employee employee) {
        employeeRepository.save(employee);
    }

    public Optional<Employee> findEmployeeById(Long id) {
        return employeeRepository.findById(id);
    }

//    @Transactional
//    public Optional<Employee> findEmployeeById(Long id) {
//        Optional<Employee> employeeOptional = employeeRepository.findById(id);
//
//        // Access the skills collection inside the transaction to initialize it
//        if (employeeOptional.isPresent()) {
//            Employee employee = employeeOptional.get();
//            employee.getSkills().size();  // Trigger lazy loading by accessing the collection
//        }
//
//        return employeeOptional;
//    }

}
