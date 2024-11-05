package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    @Query("SELECT e FROM Employee e JOIN FETCH e.projects WHERE e.id = :id")
    Optional<Employee> findEmployeeWithProjectsById(@Param("id") Long id);
}