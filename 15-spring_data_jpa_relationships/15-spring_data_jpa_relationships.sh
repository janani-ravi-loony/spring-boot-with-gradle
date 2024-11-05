######################################## 
demo-15-SpringDataJPARelationships 
########################################

########################################
######### One-to-one relationship

# Set up the one-one relationship in the employees_starter_one_to_one


# Show

Employee.java

------------------------------------
# Show
PerformanceStats.java


# Bi-Directional Access: By specifying mappedBy, you can navigate the relationship from both sides:

# You can access the PerformanceStats from an Employee.
# You can also access the Employee from PerformanceStats.



------------------------------------
# Show

EmployeeRepository.java
PerformanceRepository.java

EmployeeService.java


------------------------------------
# Show
Main.java


# Run and show the database on the H2 console

# Add this to Main.java (to show we can access employees from performance stats)

        // Access performanceStats by ID
        Optional<PerformanceStats> stats = employeeService.findPerformanceStatsById(2L);
        if (stats.isPresent()) {
            PerformanceStats performanceStats = stats.get();

            Employee employee = performanceStats.getEmployee();
            System.out.println("********");
            System.out.println(employee);
        }

---------------------------------------------------

#######################################
#### Deleting employees and performance stats

# Update EmployeeService.java

    public void deleteEmployeeById(Long id) {
        Optional<Employee> employeeOptional = employeeRepository.findById(id);

        if (employeeOptional.isPresent()) {
            Employee employee = employeeOptional.get();
            employeeRepository.delete(employee);
            // PerformanceStats will be deleted automatically if CascadeType.REMOVE or CascadeType.ALL is set
        } else {
            System.out.println("Employee with ID " + id + " not found.");
        }
    }

    public void deletePerformanceStatsById(Long id) {
        Optional<PerformanceStats> performanceStatsOptional = performanceStatsRepository.findById(id);

        if (performanceStatsOptional.isPresent()) {
            PerformanceStats stats = performanceStatsOptional.get();
            performanceStatsRepository.delete(stats);
        } else {
            System.out.println("PerformanceStats with ID " + id + " not found.");
        }
    }


# In Main.java (run one by one)

        // Delete an employee (will delete associated performance stats)
        employeeService.deleteEmployeeById(1L);

        // Try and delete performance stats (cannot be deleted standalone)
        employeeService.deletePerformanceStatsById(2L);



########################################
######### One-to-many and Many-to-one relationship

# Set up the project employees_starter_one_to_many

# Show the following files

Employee.java

# Show

Skill.java
EmployeeRepository.java
SkillRepository.java
EmployeeService.java

Main.java

# Run and show the database tables

-----------------------------------------

# Let us show that skills are lazily loaded

# Add this to the init() method in Main.java


        System.out.println("Employees and Skills saved successfully.");

        System.out.println("********************************** Load employee");

        Optional<Employee> joeOptional = employeeService.findEmployeeById(1L);

# Run and show - note in the SQL query the skills are not loaded

# Add this to access the skills

        if (joeOptional.isPresent()) {
            Employee joe = joeOptional.get();

            System.out.println("********************************** Load skills");

            System.out.println(joe.getSkills());
        }


# Run and show the exception

# The LazyInitializationException occurs in your code because the skills collection is configured to be lazily loaded (with fetch = FetchType.LAZY) and you're trying to access it outside of an active Hibernate session (or persistence context). By the time you call joe.getSkills(), the session that initially retrieved the Employee entity has been closed, so Hibernate cannot fetch the skills collection.

# Initialize the skills Collection Within the Service Layer (Recommended)
# Comment out the previous findEmployeeById and replace with this

    @Transactional
    public Optional<Employee> findEmployeeById(Long id) {
        Optional<Employee> employeeOptional = employeeRepository.findById(id);

        if (employeeOptional.isPresent()) {
            Employee employee = employeeOptional.get();
            employee.getSkills().size();  
        }

        return employeeOptional;
    }

# Run the code and show that you can access the skills now

# Can change the fetch type

fetch = FetchType.EAGER

# The list of skills are eagerly fetched


########################################
######### Many-to-many relationships

# Set up the employees_starter_many_to_many

# Show the files 

Employee.java


# Default fetch type is LAZY


# Show

Project.java
EmployeeRepository.java
ProjectRepository.java
EmployeeService.java

Main.java

# Run and show the database tables

------------------------------------------

# Update Main.java

# We will get the same lazy initialization error

        System.out.println("********************************** Load employee");

        Optional<Employee> johnOptional = employeeService.findEmployeeById(1L);

        if (joeOptional.isPresent()) {
            Employee john = johnOptional.get();

            System.out.println("********************************** Load projects");

            System.out.println(john.getProjects());
        }

# If you want to access projects for an employee can add a special call in the Employee service to fetch projects for employees

# Update EmployeeRepository.java

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    @Query("SELECT e FROM Employee e JOIN FETCH e.projects WHERE e.id = :id")
    Optional<Employee> findEmployeeWithProjectsById(@Param("id") Long id);
}

# JPQL JOIN FETCH: This query joins the Employee with its associated projects and fetches them eagerly in a single query, ensuring that the projects collection is loaded when the Employee is retrieved.

# You can change the fetch type in your Employee entity to FetchType.EAGER if you want the projects to be automatically loaded whenever the Employee is retrieved. This approach, however, may not be ideal if projects is a large collection or if it's not needed in all cases.

# Update EmployeeService.java

    @Transactional
    public List<Project> findProjectsByEmployeeId(Long id) {
        Optional<Employee> employeeOptional = employeeRepository.findEmployeeWithProjectsById(id);

        if (employeeOptional.isPresent()) {
            Employee employee = employeeOptional.get();
            return employee.getProjects(); // Projects are eagerly loaded in the query
        } else {
            return List.of(); // Return an empty list if employee is not found
        }
    }


# Update Main.java

        System.out.println("********************************** Load employee");

        List<Project> projectsJohn = employeeService.findProjectsByEmployeeId(1L);

        System.out.println(projectsJohn);

  # Run and show everything is fine

  -------------------------------------------------

  # Add an employee to a project

  # EmployeeService.java


    @Transactional
    public void addProjectToEmployee(Long employeeId, Project project) {
        Employee employee = employeeRepository.findById(employeeId).orElseThrow();

        employee.getProjects().add(project);

        saveEmployeeWithProjects(employee);
    }


# Main.java

        // Add an employee to a project
        projectX = employeeService.findProjectById(3L).orElseThrow();
        employeeService.addProjectToEmployee(1L, projectX);

# Run and show the updated tables















