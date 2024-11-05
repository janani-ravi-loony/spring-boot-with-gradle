package com.skillsoft.springboot.booksrestapi.controller;

import com.skillsoft.springboot.booksrestapi.exception.BookNotFoundException;
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
@RequestMapping("/api/books/")
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @GetMapping("{id}")
    public ResponseEntity<?> getBookById(@PathVariable("id") Long id) {
        Optional<Book> book = bookService.getBookById(id);
        if (book.isPresent()) {
            return ResponseEntity.ok(book.get());
        } else {
            throw new BookNotFoundException(id);
        }
    }

    @PostMapping
    public ResponseEntity<Book> addBook(@RequestBody Book book) {
        Book createdBook = bookService.addBook(book);
        return ResponseEntity.ok(createdBook);
    }

    @PutMapping("{id}")
    public ResponseEntity<?> updateBook(@PathVariable("id") Long id, @RequestBody Book updatedBook) {
        Optional<Book> book = bookService.updateBook(id, updatedBook);

        if (book.isPresent()) {
            return ResponseEntity.ok(book.get());
        } else {
            throw new BookNotFoundException(id);
        }
    }

    @PatchMapping("{id}")
    public ResponseEntity<?> patchBook(@PathVariable("id") Long id, @RequestBody Book partialUpdate) {
        Optional<Book> updatedBook = bookService.patchBook(id, partialUpdate);

        if (updatedBook.isPresent()) {
            return ResponseEntity.ok(updatedBook.get());
        } else {
            throw new BookNotFoundException(id);
        }
    }

    @DeleteMapping("{id}")
    public ResponseEntity<?> deleteBook(@PathVariable("id") Long id) {
        boolean isDeleted = bookService.deleteBook(id);

        if (isDeleted) {
            Map<String, String> successResponse = new HashMap<>();
            successResponse.put("message", "Book with ID " + id + " deleted successfully");
            return ResponseEntity.status(HttpStatus.OK).body(successResponse);
        } else {
            throw new BookNotFoundException(id);
        }
    }
}
