######################################## 
demo-11-SpringDataJDBC 
########################################

---------------------------

# Get set up using employees_starter

# Look at the files in this order

build.gradle

application.properties

schema.sql

Employee.java

EmployeeRepository.java

# Go into the CrudRepository interface and see the methods



Main.java

# Run and show that this just works

########################################
###### Show some other operations (v1)

# Update Main.java

package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Employee;
import com.skillsoft.springboot.repository.EmployeeRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class Main {

    @Autowired
    private EmployeeRepository employeeRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @PostConstruct
    public void init() {
        // Insert employees
        employeeRepository.save(new Employee(
                "John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee(
                "Jane Smith", "Engineer", 75000, "IT"));
        employeeRepository.save(new Employee(
                "Alice Johnson", "Manager", 90000, "Finance"));
        employeeRepository.save(new Employee(
                "Bob Brown", "Developer", 80000, "IT"));

        // Retrieve and print all employees
        System.out.println("Employees in the database:");
        employeeRepository.findAll().forEach(employee -> System.out.println(employee.toString()));

        // Access and display an entity by ID
        Long employeeId = 3L; // ID of the employee to retrieve
        System.out.println("\nRetrieve employee with ID 3:");
        employeeRepository.findById(employeeId).ifPresent(employee -> System.out.println(employee.toString()));

        // Update an entity
        Long bobId = 4L;
        employeeRepository.findById(bobId).ifPresent(bob -> {
            bob.setTitle("Senior Developer");
            bob.setSalary(85000);
            employeeRepository.save(bob);
            System.out.println("\nUpdated employee with ID 4:");
            System.out.println(bob.toString());
        });

        // Delete an entity by ID
        Long deleteId = 2L;
        employeeRepository.deleteById(deleteId);
        System.out.println("\nDeleted employee with ID 2");

        // Retrieve and print all employees after update and delete
        System.out.println("\nEmployees in the database after update and delete:");
        employeeRepository.findAll().forEach(employee -> System.out.println(employee.toString()));
    }
}


########################################
###### Custom operations  on the repository (v2)

# Update the EmployeeRepository.java file

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


# Update the Main.java file

    @PostConstruct
    public void init() {
        // Insert employees
        employeeRepository.save(new Employee("John Doe", "Recruiter", 60000, "HR"));
        employeeRepository.save(new Employee("Jane Smith", "Engineer", 75000, "IT"));
        employeeRepository.save(new Employee("Alice Johnson", "Manager", 90000, "Finance"));
        employeeRepository.save(new Employee("Bob Brown", "Developer", 80000, "IT"));

        List<Employee> itEmployees = employeeRepository.findByDepartment("IT");
        System.out.println("\nEmployees in the IT department:");
        itEmployees.forEach(employee -> System.out.println(employee.toString()));

        List<Employee> highSalaryEmployees = employeeRepository.findEmployeesWithSalaryGreaterThan(70000);
        System.out.println("\nEmployees with salary greater than 70,000:");
        highSalaryEmployees.forEach(employee -> System.out.println(employee.toString()));

        List<Employee> managers = employeeRepository.findByTitle("Manager");
        System.out.println("\nEmployees with the title 'Manager':");
        managers.forEach(employee -> System.out.println(employee.toString()));

        List<Employee> salaryRangeEmployees = employeeRepository.findEmployeesBySalaryRange(60000, 85000);
        System.out.println("\nEmployees with salary between 60,000 and 85,000:");
        salaryRangeEmployees.forEach(employee -> System.out.println(employee.toString()));
    }

  # Run and show

########################################
###### Custom update operations  on the repository (v3)

# Do this one-by-one

# EmployeeRepository.java

    @Modifying
    @Transactional
    @Query("UPDATE employees e SET e.salary = e.salary * (1 + :percentage / 100.0)")
    void increaseSalaryByPercentage(double percentage);

    @Modifying
    @Transactional
    @Query("UPDATE employees e SET e.title = :title WHERE e.id = :id")
    int updateEmployeeTitleById(@Param("id") Long id, @Param("title") String title);

# Main.java

        // Increase salary range by percentage
        employeeRepository.increaseSalaryByPercentage(10);

        Iterable<Employee> employees = employeeRepository.findAll();
        System.out.println("\nAll employees with increased salary:");
        employees.forEach(employee -> System.out.println(employee.toString()));

        // Update employee title by id
        employeeRepository.updateEmployeeTitleById(2L, "CTO");
        Optional<Employee> employee = employeeRepository.findById(2L);
        System.out.println("Employee with increased salary: " + employee.get());

# Run and show



