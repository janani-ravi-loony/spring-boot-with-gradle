package com.skillsoft.springboot.booksrestapi.service;

import com.skillsoft.springboot.booksrestapi.model.Book;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

@Service
public class BookService {
    private final Random random = new Random();

    private final List<Book> books = new ArrayList<>();

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

    public List<Book> getAllBooks() {
        return books;
    }

    public Optional<Book> getBookById(Long id) {
        return books.stream().filter(book -> book.getId().equals(id)).findFirst();
    }

    public List<Book> getBooksByYear(String year) {
        return books.stream()
                .filter(book -> book.getReleaseDate().equals(year))
                .collect(Collectors.toList());
    }

    public Book addBook(Book book) {
        long randomId = 1 + random.nextInt(1000); // Generates a random number between 1 and 1000
        book.setId(randomId);

        books.add(book);

        return book;
    }

    public Optional<Book> updateBook(Long id, Book updatedBook) {
        Optional<Book> existingBook = getBookById(id);

        if (existingBook.isPresent()) {
            Book book = existingBook.get();
            book.setTitle(updatedBook.getTitle());
            book.setAuthor(updatedBook.getAuthor());
            book.setReleaseDate(updatedBook.getReleaseDate());
            book.setBlurb(updatedBook.getBlurb());
            return Optional.of(book);
        }

        return Optional.empty();
    }

    public Optional<Book> patchBook(Long id, Book partialUpdate) {
        Optional<Book> existingBook = getBookById(id);

        if (existingBook.isPresent()) {
            Book book = existingBook.get();

            if (partialUpdate.getTitle() != null) {
                book.setTitle(partialUpdate.getTitle());
            }
            if (partialUpdate.getAuthor() != null) {
                book.setAuthor(partialUpdate.getAuthor());
            }
            if (partialUpdate.getReleaseDate() != null) {
                book.setReleaseDate(partialUpdate.getReleaseDate());
            }
            if (partialUpdate.getBlurb() != null) {
                book.setBlurb(partialUpdate.getBlurb());
            }

            return Optional.of(book);
        }

        return Optional.empty();
    }


    public boolean deleteBook(Long id) {
        Optional<Book> existingBook = getBookById(id);

        if (existingBook.isPresent()) {
            books.remove(existingBook.get());
            return true;
        }
        return false;
    }

}
