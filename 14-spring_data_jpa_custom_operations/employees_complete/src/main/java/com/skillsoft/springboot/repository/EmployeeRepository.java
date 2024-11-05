package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    List<Employee> findByName(String name);

    List<Employee> findByDepartment(String department);

    List<Employee> findBySalaryGreaterThan(int salary);

    @Query("SELECT e FROM Employee e WHERE e.name LIKE %:name%")
    List<Employee> findByNameContaining(@Param("name") String name);

    @Query("SELECT e FROM Employee e WHERE e.salary > :salary AND e.department = :department")
    List<Employee> findBySalaryAndDepartment(@Param("salary") int salary, @Param("department") String department);

    @Transactional
    @Modifying
    @Query("UPDATE Employee e SET e.salary = :salary WHERE e.id = :id")
    void updateEmployeeSalaryById(@Param("id") Long id, @Param("salary") int salary);

    @Transactional
    @Modifying
    @Query("UPDATE Employee e SET e.department = :department WHERE e.name = :name")
    void updateEmployeeDepartmentByName(@Param("name") String name, @Param("department") String department);

    @Query(value = "SELECT * FROM organization.employees WHERE department_name = :department", nativeQuery = true)
    List<Employee> findByDepartmentNative(@Param("department") String department);

    @Query(value = "SELECT * FROM organization.employees WHERE salary > :salary AND department_name = :department", nativeQuery = true)
    List<Employee> findBySalaryAndDepartmentNative(@Param("salary") int salary, @Param("department") String department);


}
