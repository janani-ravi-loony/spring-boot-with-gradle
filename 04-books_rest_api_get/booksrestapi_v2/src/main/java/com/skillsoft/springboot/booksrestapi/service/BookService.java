package com.skillsoft.springboot.booksrestapi.service;

import com.skillsoft.springboot.booksrestapi.model.Book;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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

    public Optional<Book> getBookById(Long id) {
        return books.stream().filter(book -> book.getId().equals(id)).findFirst();
    }
}
