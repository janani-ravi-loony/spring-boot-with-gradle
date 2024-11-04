package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import java.util.Optional;

@Repository
public class EmployeeRepository {

    private final JdbcTemplate jdbcTemplate;

    public EmployeeRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Employee> employeeRowMapper() {
        return (rs, rowNum) -> {
            Employee employee = new Employee();
            employee.setId(rs.getLong("id"));
            employee.setName(rs.getString("name"));
            employee.setTitle(rs.getString("title"));
            employee.setSalary(rs.getInt("salary"));
            employee.setDepartment(rs.getString("department"));
            return employee;
        };
    }

    public List<Employee> findAll() {
        return jdbcTemplate.query("SELECT * FROM EMPLOYEES", employeeRowMapper());
    }

    public Optional<Employee> findById(Long id) {
        String sql = "SELECT * FROM EMPLOYEES WHERE id = ?";

        try {
            Employee employee = jdbcTemplate.queryForObject(sql, employeeRowMapper(), id);

            return Optional.ofNullable(employee);
        } catch (Exception e) {
            return Optional.empty(); // Return empty Optional if employee not found or any error occurs
        }
    }

    public void save(Employee employee) {
        jdbcTemplate.update("INSERT INTO EMPLOYEES (name, title, salary, department) VALUES (?, ?, ?, ?)",
                employee.getName(), employee.getTitle(), employee.getSalary(), employee.getDepartment());
    }

    public void update(Employee employee) {
        jdbcTemplate.update(
                "UPDATE EMPLOYEES SET name = ?, title = ?, salary = ?, department = ? WHERE id = ?",
                employee.getName(), employee.getTitle(), employee.getSalary(),
                employee.getDepartment(), employee.getId());
    }

    public void delete(Long id) {
        jdbcTemplate.update("DELETE FROM EMPLOYEES WHERE id = ?", id);
    }
}