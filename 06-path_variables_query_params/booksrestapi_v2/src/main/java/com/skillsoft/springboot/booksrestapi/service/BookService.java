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
