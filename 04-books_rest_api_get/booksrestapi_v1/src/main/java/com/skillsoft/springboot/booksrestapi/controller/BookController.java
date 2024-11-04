package com.skillsoft.springboot.booksrestapi.controller;

import com.skillsoft.springboot.booksrestapi.model.Book;
import com.skillsoft.springboot.booksrestapi.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
public class BookController {

    @Autowired
    private BookService bookService;

    @RequestMapping("/api/books")
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }


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

}