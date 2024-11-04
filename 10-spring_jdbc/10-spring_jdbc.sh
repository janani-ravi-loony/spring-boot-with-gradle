######################################## 
demo-10-SpringJDBC 
########################################

# Get set up using employees_starter

# Look at the files in this order

build.gradle


application.properties

schema.sql

Employee.java

EmployeeRepository.java



Main.java

# Run the application and show the output

# Connect to the H2 database

http://localhost:8080/h2-console/

# Show that two records are present in the employees table

# Show the file that is created under the data/ folder
--------------------------------------

# Run the code again and see that there are now 2 more records in the Employees table (this is a persistent database)

# Make the database in-memory (so that we do not have to delete the files each time)

spring.datasource.url=jdbc:h2:mem:testdb

# Re-run, connect to the database and show

###########################################
########### Find By ID, Update, and Delete Employee (v2)

# Updates to EmployeeRepository.java

package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Employee;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class EmployeeRepository {

    private final JdbcTemplate jdbcTemplate;

    public EmployeeRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
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

# Update Main.java

package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.Optional;

@SpringBootApplication
public class Main {

    @Autowired
    private EmployeeRepository employeeRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @PostConstruct
    public void init() {
        // Insert 4 employees
        employeeRepository.save(new Employee("John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee("Jane Smith", "Engineer", 75000, "IT"));
        employeeRepository.save(new Employee("Alice Johnson", "Manager", 90000, "Finance"));
        employeeRepository.save(new Employee("Bob Brown", "Developer", 80000, "IT"));

        // Retrieve 2 employees by ID and print
        System.out.println("Retrieving employees by ID:");
        Optional<Employee> employee1 = employeeRepository.findById(2L);
        employee1.ifPresent(e -> System.out.println("Employee 2: " + e.toString()));

        Optional<Employee> employee2 = employeeRepository.findById(4L);
        employee2.ifPresent(e -> System.out.println("Employee 4: " + e.toString()));

        // Update one of the employees 
        Employee bob = employeeRepository.findById(4L).orElseThrow(() ->
                new RuntimeException("Employee not found"));
        bob.setTitle("Senior Developer");
        bob.setSalary(85000);
        employeeRepository.update(bob);
        System.out.println("Updated Employee 4: " + bob.toString());

        // Delete one employee (Delete Jane Smith)
        employeeRepository.delete(2L);
        System.out.println("Deleted Employee with ID 2");

        // Fetch and print all remaining employees
        System.out.println("Remaining employees after update and delete:");
        employeeRepository.findAll().forEach(employee -> System.out.println(employee.toString()));
    }

}


# Comment out all the extra code - make changes one by one and show

























