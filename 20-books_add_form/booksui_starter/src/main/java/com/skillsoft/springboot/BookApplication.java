package com.skillsoft.springboot;

import com.skillsoft.springboot.model.Book;
import com.skillsoft.springboot.repository.BookRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BookApplication {

    @Autowired
    private BookRepository bookRepository;

    public static void main(String[] args) {
        SpringApplication.run(BookApplication.class, args);
    }

    @PostConstruct
    public void populateDatabase() {
        bookRepository.save(new Book("1984", "George Orwell", "June 1949",
                "A dystopian novel set in a totalitarian society ruled by Big Brother."));
        bookRepository.save(new Book("To Kill a Mockingbird", "Harper Lee", "July 1960",
                "A novel about racial inequality and the loss of innocence."));
        bookRepository.save(new Book("The Great Gatsby", "F. Scott Fitzgerald", "April 1925",
                "A novel that explores themes of wealth, society, and the American Dream."));
        bookRepository.save(new Book("Pride and Prejudice", "Jane Austen", "January 1813",
                "A romantic novel that critiques the British landed gentry at the end of the 18th century."));
        bookRepository.save(new Book("Moby Dick", "Herman Melville", "October 1851",
                "The narrative of Captain Ahab's obsessive quest to defeat the white whale, Moby Dick."));


        System.out.println("Database has been populated with real book data.");
    }
}
