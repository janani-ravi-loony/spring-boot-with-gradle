package com.skillsoft.springboot.service;

import com.skillsoft.springboot.model.Book;
import com.skillsoft.springboot.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }

    public Book addBook(Book book) {
        return bookRepository.save(book);
    }

    public Optional<Book> updateBook(Long id, Book updatedBook) {
        if (bookRepository.existsById(id)) {
            updatedBook.setId(id);
            return Optional.of(bookRepository.save(updatedBook));
        }
        return Optional.empty();
    }

    public Optional<Book> patchBook(Long id, Book partialUpdate) {
        Optional<Book> existingBookOpt = bookRepository.findById(id);

        if (existingBookOpt.isPresent()) {
            Book existingBook = existingBookOpt.get();

            // Update only non-null fields in the partialUpdate object
            if (partialUpdate.getTitle() != null) {
                existingBook.setTitle(partialUpdate.getTitle());
            }

            if (partialUpdate.getAuthor() != null) {
                existingBook.setAuthor(partialUpdate.getAuthor());
            }

            if (partialUpdate.getReleaseDate() != null) {
                existingBook.setReleaseDate(partialUpdate.getReleaseDate());
            }

            if (partialUpdate.getBlurb() != null) {
                existingBook.setBlurb(partialUpdate.getBlurb());
            }

            // Save the updated entity back to the database
            Book updatedBook = bookRepository.save(existingBook);
            return Optional.of(updatedBook);
        }

        return Optional.empty(); // Return empty if book not found
    }

    public boolean deleteBook(Long id) {
        if (bookRepository.existsById(id)) {
            bookRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
