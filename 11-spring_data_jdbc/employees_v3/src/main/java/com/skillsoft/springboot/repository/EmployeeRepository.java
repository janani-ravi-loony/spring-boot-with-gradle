package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface EmployeeRepository extends CrudRepository<Employee, Long> {
    @Query("SELECT * FROM employees WHERE department = :department")
    List<Employee> findByDepartment(String department);

    @Query("SELECT * FROM employees WHERE salary > :salary")
    List<Employee> findEmployeesWithSalaryGreaterThan(int salary);

    @Query("SELECT * FROM employees WHERE title = :title")
    List<Employee> findByTitle(String title);

    @Query("SELECT * FROM employees WHERE salary BETWEEN :minSalary AND :maxSalary")
    List<Employee> findEmployeesBySalaryRange(int minSalary, int maxSalary);

    @Modifying
    @Transactional
    @Query("UPDATE employees e SET e.salary = e.salary * (1 + :percentage / 100.0)")
    void increaseSalaryByPercentage(double percentage);

    @Modifying
    @Transactional
    @Query("UPDATE employees e SET e.title = :title WHERE e.id = :id")
    int updateEmployeeTitleById(@Param("id") Long id, @Param("title") String title);
}
