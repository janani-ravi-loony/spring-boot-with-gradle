package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmployeeRepository {

    private final JdbcTemplate jdbcTemplate;

    public EmployeeRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Employee> findAll() {
        return jdbcTemplate.query("SELECT * FROM EMPLOYEES", (rs, rowNum) -> {
            Employee employee = new Employee();
            employee.setId(rs.getLong("id"));
            employee.setName(rs.getString("name"));
            employee.setTitle(rs.getString("title"));
            employee.setSalary(rs.getInt("salary"));
            employee.setDepartment(rs.getString("department"));
            return employee;
        });
    }

    public void save(Employee employee) {
        jdbcTemplate.update("INSERT INTO EMPLOYEES (name, title, salary, department) VALUES (?, ?, ?, ?)",
                employee.getName(), employee.getTitle(), employee.getSalary(), employee.getDepartment());
    }
}
