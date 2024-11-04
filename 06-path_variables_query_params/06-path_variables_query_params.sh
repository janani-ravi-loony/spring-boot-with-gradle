######################################## 
demo-06-PathVariablesQueryParameters
########################################

########################################
#### Path Variables

# Continue in the same booksrestapi project

# Update Book.java to have a category

package com.skillsoft.springboot.booksrestapi.model;

public class Book {
    private Long id;
    private String title;
    private String author;
    private String releaseDate;
    private String blurb;
    private String category;

    public Book(Long id, String title, String author, String releaseDate, String blurb, String category) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.releaseDate = releaseDate;
        this.blurb = blurb;
        this.category = category;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }

    public String getBlurb() { return blurb; }
    public void setBlurb(String blurb) { this.blurb = blurb; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}


# Update BookService.java to be able to retrieve data by category and id

package com.skillsoft.springboot.booksrestapi.service;

import com.skillsoft.springboot.booksrestapi.model.Book;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class BookService {
    private final List<Book> books = new ArrayList<>();

    public BookService() {
        // Fiction books
        books.add(new Book(1L, "The Catcher in the Rye", "J.D. Salinger",
                "1951", "A classic novel", "fiction"));
        books.add(new Book(2L, "1984", "George Orwell",
                "1949", "A dystopian novel", "fiction"));
        books.add(new Book(3L, "To Kill a Mockingbird", "Harper Lee",
                "1960", "A novel about racial injustice", "fiction"));

        // Science books
        books.add(new Book(4L, "A Brief History of Time", "Stephen Hawking",
                "1988", "A science book", "science"));
        books.add(new Book(5L, "The Selfish Gene", "Richard Dawkins",
                "1976", "A book on evolutionary biology", "science"));
        books.add(new Book(6L, "The Origin of Species", "Charles Darwin",
                "1859", "The foundation of evolutionary biology", "science"));

        // History books
        books.add(new Book(7L, "Sapiens", "Yuval Noah Harari",
                "2011", "A brief history of humankind", "history"));
        books.add(new Book(8L, "Guns, Germs, and Steel", "Jared Diamond",
                "1997", "A study of civilizations and development", "history"));

        // Technology books
        books.add(new Book(9L, "The Innovators", "Walter Isaacson",
                "2014", "The history of technology pioneers", "technology"));
        books.add(new Book(10L, "Clean Code", "Robert C. Martin",
                "2008", "A guide to writing clean, maintainable code", "technology"));
    }

    public List<Book> getAllBooks() {
        return books;
    }

    public List<Book> getBooksByCategory(String category) {
        return books.stream()
                .filter(book -> book.getCategory().equalsIgnoreCase(category))
                .collect(Collectors.toList());
    }

    public Optional<Book> getBookByCategoryAndId(String category, Long id) {
        return books.stream()
                .filter(book -> book.getCategory().equalsIgnoreCase(category) && book.getId().equals(id))
                .findFirst();
    }

    public boolean deleteBookByCategoryAndId(String category, Long id) {
        Optional<Book> existingBook = getBookByCategoryAndId(category, id);

        if (existingBook.isPresent()) {
            books.remove(existingBook.get());
            return true;
        }
        return false;
    }
}


# Update BookController.java to retrieve books by category and id using path variables

package com.skillsoft.springboot.booksrestapi.controller;

import com.skillsoft.springboot.booksrestapi.model.Book;
import com.skillsoft.springboot.booksrestapi.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/categories")
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping("/books")
    public ResponseEntity<List<Book>> getAllBooks() {
        List<Book> books = bookService.getAllBooks();
        return ResponseEntity.ok(books);
    }

    @GetMapping("/{category}/books")
    public ResponseEntity<List<Book>> getBooksByCategory(@PathVariable("category") String category) {
        List<Book> books = bookService.getBooksByCategory(category);
        if (books.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.ok(books);
    }

    @GetMapping("/{category}/books/{id}")
    public ResponseEntity<Book> getBookByCategoryAndId(
            @PathVariable("category") String category, @PathVariable("id") Long id) {
        Optional<Book> book = bookService.getBookByCategoryAndId(category, id);
        return book.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{category}/books/{id}")
    public ResponseEntity<?> deleteBookByCategoryAndId(
            @PathVariable("category") String category, @PathVariable("id") Long id) {
        boolean isDeleted = bookService.deleteBookByCategoryAndId(category, id);

        if (isDeleted) {
            Map<String, String> successResponse = new HashMap<>();
            successResponse.put("message", "Book with ID " + id + " in category '" + category + "' deleted successfully");
            return ResponseEntity.status(HttpStatus.OK).body(successResponse);
        } else {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Book with ID " + id + " in category '" + category + "' not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }
}


# Run the server

# Retrieve all books
curl -X GET http://localhost:8080/api/categories/books | jq

# Retrieve fiction books
curl -X GET http://localhost:8080/api/categories/fiction/books | jq

# Retrieve books by category and id
curl -X GET http://localhost:8080/api/categories/fiction/books/1 | jq 

# Delete a book by category and id
curl -X DELETE http://localhost:8080/api/categories/fiction/books/1 | jq


########################################
#### Query Parameters (v2)

# NOTES:
# Query param name not mandatory: If the query parameter name and the method parameter name are the same, you don't need to specify it explicitly.

# Update BookController.java

package com.skillsoft.springboot.booksrestapi.controller;

import com.skillsoft.springboot.booksrestapi.model.Book;
import com.skillsoft.springboot.booksrestapi.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
        List<Book> books = bookService.getAllBooks();
        return ResponseEntity.ok(books);
    }

    @GetMapping("/category")
    public ResponseEntity<List<Book>> getBooksByCategory(@RequestParam String category) {
        List<Book> books = bookService.getBooksByCategory(category);
        if (books.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.ok(books);
    }

    @GetMapping("/book")
    public ResponseEntity<Book> getBookByCategoryAndId(
            @RequestParam String category,
            @RequestParam Long id) {

        Optional<Book> book = bookService.getBookByCategoryAndId(category, id);
        return book.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping
    public ResponseEntity<?> deleteBookByCategoryAndId(
            @RequestParam String category,
            @RequestParam Long id) {

        boolean isDeleted = bookService.deleteBookByCategoryAndId(category, id);

        if (isDeleted) {
            Map<String, String> successResponse = new HashMap<>();
            successResponse.put("message", 
                "Book with ID " + id + " in category '" + category + "' deleted successfully");
            return ResponseEntity.status(HttpStatus.OK).body(successResponse);
        } else {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", 
                "Book with ID " + id + " in category '" + category + "' not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }
}

# Run the server 

# On the terminal

curl -X GET "http://localhost:8080/api/books" | jq

curl -X GET "http://localhost:8080/api/books/category?category=technology" | jq

curl -X GET "http://localhost:8080/api/books/book?category=technology&id=9" | jq

curl -X DELETE "http://localhost:8080/api/books?category=technology&id=10" | jq

# Everything works

########################################
#### Query Parameters (v3)

# For every category change the parameter variable to bind to to be "cat"

@RequestParam("cat") 

# Your queries change like this

curl -X GET "http://localhost:8080/api/books/category?cat=technology" | jq

curl -X GET "http://localhost:8080/api/books/book?cat=technology&id=9" | jq 



























