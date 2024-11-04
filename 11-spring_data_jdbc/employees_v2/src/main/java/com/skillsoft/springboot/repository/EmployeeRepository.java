package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.jdbc.repository.query.Query;
import java.util.List;

public interface EmployeeRepository extends CrudRepository<Employee, Long> {

    @Query("SELECT * FROM employees WHERE department = :department")
    List<Employee> findByDepartment(String department);

    @Query("SELECT * FROM employees WHERE salary > :salary")
    List<Employee> findEmployeesWithSalaryGreaterThan(int salary);

    @Query("SELECT * FROM employees WHERE title = :title")
    List<Employee> findByTitle(String title);

    @Query("SELECT * FROM employees WHERE salary BETWEEN :minSalary AND :maxSalary")
    List<Employee> findEmployeesBySalaryRange(int minSalary, int maxSalary);
}
