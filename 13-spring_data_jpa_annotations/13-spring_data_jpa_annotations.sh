######################################## 
demo-13-SpringDataJPAAnnotations 
########################################

# Continue in the same "employees" database

----------------------
# Remove the @Table annotation from the Employee class

# Run and show that the database is now called "Employee"

# Go to the H2 console to show this

------------------------

# Change the table name as follows

@Table(name = "employee_table")

# Show teh update in the H2 console

########################################
#### Schema and initialization scripts (v2)


# If you want to create a schema you can set up an initialization script for it

# Create schema.sql in src/main/resources

CREATE SCHEMA IF NOT EXISTS organization;

# Update application.properties

spring.datasource.schema=classpath:schema.sql
spring.jpa.properties.hibernate.default_schema=organization

# Update the annotation in the Employee.java file

@Table(name = "employees", schema = "organization")

# Run and show that the table is created in the schema


########################################
#### Other Table configurations (v2)

# Employee.java

# Set up a unique constraint on a column
@Table(
    name = "employees",
    schema = "organization",
    uniqueConstraints = @UniqueConstraint(columnNames = {"name"})
)

# Update the init() method in Main.java to have non-unique names

        Employee emp3 = new Employee(
                "Charlie Brown", "Software Engineer", 92000, "IT");
        Employee emp4 = new Employee(
                "Charlie Brown", "Financial Analyst", 78000, "Finance");

 # Run the code and show the constraint is violated 

 # Immediately fix this so the names are unique


 # Update the table annotation

@Table(
    name = "employees",
    schema = "organization",
    uniqueConstraints = @UniqueConstraint(columnNames = {"name"}),
    indexes = @Index(columnList = "department")
)

 # Run and show

 # On the H2 console show that these indexes are created


########################################
#### Column annotations (v3)

# Set up annotations on the columns in Employee.java

    @Column(name = "employee_name", nullable = false, length = 100, unique = true)
    private String name;

    @Column(name = "job_title", length = 50)
    private String title;

    @Column(name = "salary", nullable = false)
    private int salary;

    @Column(name = "dept_name", length = 100)
    private String department;

# Will have to update the index

@Table(
    name = "employees",
    schema = "organization",
    uniqueConstraints = @UniqueConstraint(columnNames = {"name"}),
    indexes = @Index(columnList = "dept_name")
)

# In Main.java change a query to violate the job_title length

# Make the length in one of the employees very long for the job_title

# Run and show the error



########################################
#### Other annotations (v4)

# Using enums for fields

# Define the enum

    public enum EmployeeType {
        FULL_TIME, PART_TIME, CONTRACT
    }

# Add the property

    @Enumerated(EnumType.STRING)
    private EmployeeType employeeType;

# Update the constructor

    public Employee(String name, String title, int salary, String department, EmployeeType employeeType) {
        this.name = name;
        this.title = title;
        this.salary = salary;
        this.department = department;
        this.employeeType = employeeType;
    }

# Getters and setters

    public EmployeeType getEmployeeType() {
        return employeeType;
    }

    public void setEmployeeType(EmployeeType employeeType) {
        this.employeeType = employeeType;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", name=" + name +
                ", title=" + title +
                ", salary=" + salary +
                ", department=" + department +
                ", type=" + employeeType +
                '}';
    }

# Update Main.java


    @PostConstruct
    public void init() {
        Employee emp1 = new Employee(
                "Alice Johnson", "HR Manager", 68000,
                "Human Resources", Employee.EmployeeType.FULL_TIME);
        Employee emp2 = new Employee(
                "Bob Williams", "Marketing Specialist", 54000,
                "Marketing", Employee.EmployeeType.PART_TIME);
        Employee emp3 = new Employee(
                "Charlie Brown", "Software Engineer", 92000,
                "IT", Employee.EmployeeType.CONTRACT);
        Employee emp4 = new Employee(
                "Diana Evans", "Financial Analyst", 78000,
                "Finance", Employee.EmployeeType.FULL_TIME);

        employeeRepository.save(emp1);
        employeeRepository.save(emp2);
        employeeRepository.save(emp3);
        employeeRepository.save(emp4);

        List<Employee> employees = employeeRepository.findAll();
        employees.forEach(emp -> System.out.println(emp.toString()));
    }

----------------------------------
# Add a transient field

# Employee.java

  @Transient  // This field will not be persisted in the database
    private double bonus;

# Update contructor

    public Employee(String name, String title, int salary, String department, EmployeeType employeeType) {
        this.name = name;
        this.title = title;
        this.salary = salary;
        this.department = department;
        this.employeeType = employeeType;
        this.bonus =this.salary * 0.10;
    }

# Update toString()

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", name=" + name +
                ", title=" + title +
                ", salary=" + salary +
                ", department=" + department +
                ", type=" + employeeType +
                ", bonus=" + bonus +
                '}';
    }

# Main.java


    @PostConstruct
    public void init() {
        Employee emp1 = new Employee(
                "Alice Johnson", "HR Manager", 68000,
                "Human Resources", Employee.EmployeeType.FULL_TIME);
        System.out.println(emp1);

        Employee emp2 = new Employee(
                "Bob Williams", "Marketing Specialist", 54000,
                "Marketing", Employee.EmployeeType.PART_TIME);
        System.out.println(emp2);

        Employee emp3 = new Employee(
                "Charlie Brown", "Software Engineer", 92000,
                "IT", Employee.EmployeeType.CONTRACT);
        System.out.println(emp3);

        Employee emp4 = new Employee(
                "Diana Evans", "Financial Analyst", 78000,
                "Finance", Employee.EmployeeType.FULL_TIME);
        System.out.println(emp4);

        employeeRepository.save(emp1);
        employeeRepository.save(emp2);
        employeeRepository.save(emp3);
        employeeRepository.save(emp4);

        List<Employee> employees = employeeRepository.findAll();
        employees.forEach(emp -> System.out.println(emp.toString()));
    }

# Run and show

























