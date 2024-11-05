######################################## 
demo-16-RESTAPIWithJPA 
########################################

# Set up with booksrestapi_starter (this will have errors)

# Show what we already have

build.gradle
application.properties
BookController.java
BooksApplication.java

# Project
# To set up the following files

model/Book.java
repository/BookRepository.java
service/BookService.java

# Modify the BooksApplication.java to insert a few records into the table to start off with
  @Autowired
  private BookRepository bookRepository;

  ...

	@PostConstruct
	public void populateDatabase() {
		bookRepository.save(new Book("1984", "George Orwell", "1949-06-08",
				"A dystopian novel set in a totalitarian society ruled by Big Brother."));
		bookRepository.save(new Book("To Kill a Mockingbird", "Harper Lee", "1960-07-11",
				"A novel about racial inequality and the loss of innocence."));
		bookRepository.save(new Book("The Great Gatsby", "F. Scott Fitzgerald", "1925-04-10",
				"A novel that explores themes of wealth, society, and the American Dream."));
		bookRepository.save(new Book("Pride and Prejudice", "Jane Austen", "1813-01-28",
				"A romantic novel that critiques the British landed gentry at the end of the 18th century."));
		bookRepository.save(new Book("Moby Dick", "Herman Melville", "1851-10-18",
				"The narrative of Captain Ahab's obsessive quest to defeat the white whale, Moby Dick."));

		System.out.println("Database has been populated with real book data.");
	}


# These are the commands to test books

curl -X GET "http://localhost:8080/api/books/" -H "Accept: application/json" | jq

curl -X GET "http://localhost:8080/api/books/1" -H "Accept: application/json" | jq

curl -X POST "http://localhost:8080/api/books/" \
-H "Content-Type: application/json" \
-d '{
  "title": "The Catcher in the Rye",
  "author": "J.D. Salinger",
  "releaseDate": "1951-07-16",
  "blurb": "The story of a teenager, Holden Caulfield, in 1950s New York City."
}' | jq

curl -X PUT "http://localhost:8080/api/books/1" \
-H "Content-Type: application/json" \
-d '{
  "title": "The Catcher in the Rye",
  "author": "J.D. Salinger",
  "releaseDate": "1951-07-16",
  "blurb": "A revised blurb for the story of Holden Caulfield."
}' | jq

curl -X PATCH "http://localhost:8080/api/books/1" \
-H "Content-Type: application/json" \
-d '{
  "blurb": "Updated blurb with more details."
}' | jq

curl -X DELETE "http://localhost:8080/api/books/1" | jq


########################################
##### Error handling in REST APIs


# Create a new package under springboot

exception/

# Create a new class 

BookNotFoundException.java

# Add code to the class

package com.skillsoft.springboot.booksrestapi.exception;

public class BookNotFoundException extends RuntimeException {

    public BookNotFoundException(Long id) {
        super("Book with ID " + id + " not found");
    }
}

# Under the exception package create another file 

GlobalExceptionHandler.java

# Add code to the class

package com.skillsoft.springboot.booksrestapi.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BookNotFoundException.class)
    public ResponseEntity<?> handleBookNotFoundException(BookNotFoundException ex) {
        Map<String, String> errorResponse = new HashMap<>();
        errorResponse.put("message", ex.getMessage());
        errorResponse.put("status", HttpStatus.NOT_FOUND.toString());

        return new ResponseEntity<>(errorResponse, HttpStatus.NOT_FOUND);
    }
}


# Go to Book Controller and replace all errors by throwing this exception example below (do this for all methods)

    @PutMapping("{id}")
    public ResponseEntity<?> updateBook(@PathVariable("id") Long id, @RequestBody Book updatedBook) {
        Optional<Book> book = bookService.updateBook(id, updatedBook);

        if (book.isPresent()) {
            return ResponseEntity.ok(book.get());
        } else {
            throw new BookNotFoundException(id);
        }
    }


# On the terminal

curl -X DELETE "http://localhost:8080/api/books/10" | jq

# Should get a nice error message!

curl -X GET "http://localhost:8080/api/books/23" -H "Accept: application/json" | jq




















