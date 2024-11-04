######################################## 
demo-04-BooksRESTAPI 
########################################
# To set up a REST API server in Spring Boot for retrieving books, you’ll need the following components:

# Show a diagram of how the layers interact

######################################
### v1


# In the existing project

# Create a model/ folder under com.skillsoft.springboot.booksrestapi

# Set up the Book.java file

# Can just set up the member variables
# Right click -> Generate -> Constructor
# Right click -> Generate -> Getters and Setters

package com.skillsoft.springboot.booksrestapi.model;

public class Book {
    private Long id;
    private String title;
    private String author;
    private String releaseDate;
    private String blurb;

    public Book(Long id, String title, String author, String releaseDate, String blurb) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.releaseDate = releaseDate;
        this.blurb = blurb;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getBlurb() {
        return blurb;
    }

    public void setBlurb(String blurb) {
        this.blurb = blurb;
    }
}


# Create a new package

service

# Set up the following class

BookService.java

# This is the code

package com.skillsoft.springboot.booksrestapi.service;

import com.skillsoft.springboot.booksrestapi.model.Book;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
public class BookService {
    private final List<Book> books = new ArrayList<>();

    public BookService() {
        // Sample books for in-memory storage
        books.add(new Book(1L, "The Catcher in the Rye",
                "J.D. Salinger", "1951", "A classic novel"));
        books.add(new Book(2L, "1984",
                "George Orwell", "1949", "A dystopian social science novel"));
    }

    public List<Book> getAllBooks() {
        return books;
    }
}

# Now set up the controller layer, create a package

controller

# Set up this class

BookController.java

# Code is here

package com.skillsoft.springboot.booksrestapi.controller;

import com.skillsoft.springboot.booksrestapi.model.Book;
import com.skillsoft.springboot.booksrestapi.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
public class BookController {

    @Autowired
    private BookService bookService;

    @RequestMapping("/api/books")
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }
}

##########################################

# The API is now set up

# Go to

http://localhost:8080/api/books

# Notice the response is automatically in the JSON format!


# Now try to access the details of a specific book

http://localhost:8080/api/books/1
http://localhost:8080/api/books/2

# This does not work

#########################################

# Retrieving a book by id

# Add this to the BookService.java class

    public Optional<Book> getBookById(Long id) {
        return books.stream().filter(book -> book.getId().equals(id)).findFirst();
    }

# Add this to the BookController.java class

    @RequestMapping("/api/books/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Long id) {
        Optional<Book> book = bookService.getBookById(id);
        if (book.isPresent()) {
            return ResponseEntity.ok(book.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

# Now restart the server and try accessing specific books

http://localhost:8080/api/books/
http://localhost:8080/api/books/1
http://localhost:8080/api/books/2

# When we access a book that does not exist we get a non-existent page

http://localhost:8080/api/books/3

################################
## V2

# Let's display a better response if the book does not exist

# Update the BookController.java file

    @RequestMapping("/api/books/{id}")
    public ResponseEntity<?> getBookById(@PathVariable Long id) {
        Optional<Book> book = bookService.getBookById(id);
        if (book.isPresent()) {
            return ResponseEntity.ok(book.get());
        } else {
            // Set up an error message
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Book with ID " + id + " not found");
            errorResponse.put("status", HttpStatus.NOT_FOUND.toString());
            return new ResponseEntity<>(errorResponse, HttpStatus.NOT_FOUND);
        }
    }

 # Import new classes as needed

 # When we access a book that does not exist we get a nice error message
http://localhost:8080/api/books/3

 ##################################

 # Note that we have to specify the entire "/api/books" path in each RequestMapping class

 # In BookController.java change annotations as follows

@RestController
@RequestMapping("/api/books/")
public class BookController {


	    @GetMapping
	    public List<Book> getAllBooks() {}

		@GetMapping("{id}")
		public ResponseEntity<?> getBookById(@PathVariable Long id) {}

}


# Run and show

 ##################################

# Can return XML responses as well

# Add this to the build.gradle file dependencies

implementation 'com.fasterxml.jackson.dataformat:jackson-dataformat-xml'


# Add this to the Book element in Book.java

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

@JacksonXmlRootElement(localName = "book")
public class Book {


# In BookController.java

    @GetMapping(produces = { "application/json", "application/xml" })
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @GetMapping(path = "{id}", produces = { "application/json", "application/xml" })
    public ResponseEntity<?> getBookById(@PathVariable Long id) {
    }

# Restart the server

# On the browser

http://localhost:8080/api/books
http://localhost:8080/api/books/1

# This is now in XML!

# On the terminal

curl -H "Accept: application/json" http://localhost:8080/api/books/ | jq

curl -H "Accept: application/json" http://localhost:8080/api/books/1 | jq

curl -H "Accept: application/xml" http://localhost:8080/api/books/1

###################################
# v3

## TO PRACTICE

## Add a method to retrieve books by year

# BookService.java

    public BookService() {
        books.add(new Book(1L, "The Catcher in the Rye",
                "J.D. Salinger", "1951", "A classic novel"));
        books.add(new Book(2L, "1984",
                "George Orwell", "1949", "A dystopian social science novel"));
        books.add(new Book(3L, "Fahrenheit 451",
                "Ray Bradbury", "1953", "A novel about censorship"));
        books.add(new Book(4L, "Lord of the Flies",
                "William Golding", "1954", "A novel about human nature"));
        books.add(new Book(5L, "On the Road",
                "Jack Kerouac", "1957", "A novel about the Beat Generation"));
        books.add(new Book(6L, "Lolita",
                "Vladimir Nabokov", "1955", "A controversial novel"));
        books.add(new Book(7L, "Animal Farm",
                "George Orwell", "1945", "A political allegory"));
        books.add(new Book(8L, "Go Tell It on the Mountain",
                "James Baldwin", "1953", "A semi-autobiographical novel"));
    }
    public List<Book> getBooksByYear(String year) {
        return books.stream()
                .filter(book -> book.getReleaseDate().equals(year))
                .collect(Collectors.toList());
    }

# BookController.java

    @GetMapping(path = "/year/{year}", produces = { "application/json", "application/xml" })
    public ResponseEntity<?> getBooksByYear(@PathVariable String year) {
        List<Book> books = bookService.getBooksByYear(year);
        if (books.isEmpty()) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "No books found for year " + year);
            errorResponse.put("status", HttpStatus.NOT_FOUND.toString());
            return new ResponseEntity<>(errorResponse, HttpStatus.NOT_FOUND);
        } else {
            return ResponseEntity.ok(books);
        }
    }

# Try out on the brower

http://localhost:8080/api/books/year/1953







