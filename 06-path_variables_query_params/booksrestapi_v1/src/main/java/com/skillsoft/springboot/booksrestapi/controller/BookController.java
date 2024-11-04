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
