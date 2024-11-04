######################################## 
demo-12-SpringDataJPA 
########################################

# JPA and Hibernate


-----------------------------------------------------------

########################################
###### Set up database integration using JPA (employee_starter)


# Show the following files

build.gradle

application.properties


Employee.java



EmployeeRepository.java

Main.java

#######################################
#### Perform other operations on the table (v1)

# Update Main.java

    @PostConstruct
    public void init() {
        Employee emp1 = new Employee(
                "Alice Johnson", "HR Manager", 68000, "Human Resources");
        Employee emp2 = new Employee(
                "Bob Williams", "Marketing Specialist", 54000, "Marketing");
        Employee emp3 = new Employee(
                "Charlie Brown", "Software Engineer", 92000, "IT");
        Employee emp4 = new Employee(
                "Diana Evans", "Financial Analyst", 78000, "Finance");

        employeeRepository.save(emp1);
        employeeRepository.save(emp2);
        employeeRepository.save(emp3);
        employeeRepository.save(emp4);

        Iterable<Employee> employees = employeeRepository.findAll();
        employees.forEach(System.out::println);

        Employee employeeById = employeeRepository.findById(emp1.getId()).orElse(null);
        if (employeeById != null) {
            System.out.println("Employee found by ID: " + employeeById);
        }

        Objects.requireNonNull(employeeById).setSalary(70000);
        employeeRepository.save(employeeById);
        System.out.println("Updated employee: " + employeeRepository.findById(emp1.getId()).orElse(null));

        employeeRepository.deleteById(emp2.getId());
        System.out.println("Deleted employee with ID: " + emp2.getId());

        Employee deletedEmployee = employeeRepository.findById(emp2.getId()).orElse(null);
        if (deletedEmployee == null) {
            System.out.println("Employee with ID " + emp2.getId() + " was successfully deleted.");
        }
    }














































