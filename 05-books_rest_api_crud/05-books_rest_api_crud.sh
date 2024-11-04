######################################## 
demo-05-BooksRestApiCRUD
########################################

# Run the existing code

# Terminal
curl -H "Accept: application/json" http://localhost:8080/api/books/ | jq

# But we cannot add books

curl -X POST http://localhost:8080/api/books/ \
-H "Content-Type: application/json" \
-d '{
    "title": "Brave New World",
    "author": "Aldous Huxley",
    "releaseDate": "1932",
    "blurb": "A dystopian science fiction novel."
}' | jq



#############################################
## Add books (v1)

# In the Book.java file

    public Book() {
        // Default constructor required for JSON deserialization
    }


# In the BookService.java file

    private final Random random = new Random();

...

    public Book addBook(Book book) {
        long randomId = 1 + random.nextInt(1000); // Generates a random number between 1 and 1000
        book.setId(randomId);

        books.add(book);

        return book;
    }

# In the BookController.java file
    @PostMapping
    public ResponseEntity<Book> addBook(@RequestBody Book book) {
        Book createdBook = bookService.addBook(book);
        return ResponseEntity.ok(createdBook);
    }

# Re-run the server

# Now make the curl request

curl -X POST http://localhost:8080/api/books/ \
-H "Content-Type: application/json" \
-d '{
    "title": "Brave New World",
    "author": "Aldous Huxley",
    "releaseDate": "1932",
    "blurb": "A dystopian science fiction novel."
}' | jq

# This should work now!

#############################################
## Update books (v2)

# We will use the PUT request which is a complete update of the books (all properties of the book will be updated)

# The server should still be running (we have automatic restart)

# First try this update - it should fail
curl -X PUT http://localhost:8080/api/books/1 \
-H "Content-Type: application/json" \
-d '{
    "title": "Updated Book Title",
    "author": "Updated Author",
    "releaseDate": "2022",
    "blurb": "Updated blurb of the book."
}' | jq


# Now add in the code to update a book

# BookService.java

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

# BookController.java

# Note that the PathVariable does not specify what parameter it binds to

    @PutMapping("{id}")
    public ResponseEntity<?> updateBook(@PathVariable Long id, @RequestBody Book updatedBook) {
        Optional<Book> book = bookService.updateBook(id, updatedBook);

        if (book.isPresent()) {
            return ResponseEntity.ok(book.get());
        } else {
            // Return a message if the book does not exist
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Book with ID " + id + " not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }

# First run using IntelliJ

# On the terminal

# Run this

curl -X PUT http://localhost:8080/api/books/1 \
-H "Content-Type: application/json" \
-d '{
    "title": "Updated Book Title",
    "author": "Updated Author",
    "releaseDate": "2022",
    "blurb": "Updated blurb of the book."
}' | jq

# This works!

# Now stop the IntelliJ server and run on the terminal

# Make sure you are in this folder
...../IDEAProjects/booksrestapi

# Run the server

gradle bootRun

# Try to update a book

curl -X PUT http://localhost:8080/api/books/2 \
-H "Content-Type: application/json" \
-d '{
    "title": "Updated Book Title",
    "author": "Updated Author",
    "releaseDate": "2022",
    "blurb": "Updated blurb of the book."
}' | jq

# NOTE the error!

# Servlet.service() for servlet [dispatcherServlet] in context with path [] threw exception [Request processing failed: java.lang.IllegalArgumentException: Name for argument of type [java.lang.Long] not specified, and parameter name information not available via reflection. Ensure that the compiler uses the '-parameters' flag.] with root cause

# Try making the GET request from here (this worked earlier)

curl -H "Accept: application/json" http://localhost:8080/api/books/2 | jq

# This does not work as well! Same error

--------------------------------------------------
# Now kill the server running on the terminal

# Start the server on IntelliJ

curl -H "Accept: application/json" http://localhost:8080/api/books/2 | jq

# and

curl -X PUT http://localhost:8080/api/books/1 \
-H "Content-Type: application/json" \
-d '{
    "title": "Updated Book Title",
    "author": "Updated Author",
    "releaseDate": "2022",
    "blurb": "Updated blurb of the book."
}' | jq

# Now this works - why the difference?

# IDEs automatically preserve the parameters in the path so Spring is able to determine what variable from the URL to bind to. 

# Preserving the parameters in the path is done by passing the --parameters flag

# So how do we run from the command line?

# Kill the server and update the build.gradle file

tasks.withType(JavaCompile).configureEach {
    options.compilerArgs << '-parameters'
}

# Now on the terminal

gradle bootRun

# Make the update request

curl -X PUT http://localhost:8080/api/books/1 \
-H "Content-Type: application/json" \
-d '{
    "title": "Updated Book Title",
    "author": "Updated Author",
    "releaseDate": "2022",
    "blurb": "Updated blurb of the book."
}' | jq

# It should be successful!

#############################################
## Explicitly specifying path variables to bind to (v3)

# You can explicitly tell Spring the name of the path variable by adding the value attribute in the @PathVariable annotation, like this:

# Update two methods that use the ID

public ResponseEntity<?> getBookById(@PathVariable("id") Long id)

# and

public ResponseEntity<?> getBooksByYear(@PathVariable("year") String year)

# and

public ResponseEntity<?> updateBook(@PathVariable("id") Long id, @RequestBody Book updatedBook)

# All of these should work now

curl -H "Accept: application/json" http://localhost:8080/api/books/2 | jq

curl -H "Accept: application/json" http://localhost:8080/api/books/year/1955 | jq

curl -X PUT http://localhost:8080/api/books/1 \
-H "Content-Type: application/json" \
-d '{
    "title": "Updated Book Title",
    "author": "Updated Author",
    "releaseDate": "2022",
    "blurb": "Updated blurb of the book."
}' | jq

#############################################
## Patch request to partially udpate books (v4)

# BookService.java

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


# BookController.java

    @PatchMapping("{id}")
    public ResponseEntity<?> patchBook(@PathVariable("id") Long id, @RequestBody Book partialUpdate) {
        Optional<Book> updatedBook = bookService.patchBook(id, partialUpdate);

        if (updatedBook.isPresent()) {
            return ResponseEntity.ok(updatedBook.get());
        } else {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Book with ID " + id + " not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }

# Make a curl request

curl -X PATCH http://localhost:8080/api/books/1 \
-H "Content-Type: application/json" \
-d '{
    "title": "Partially Updated Title"
}' | jq

# Confirm update with a GET request
curl -H "Accept: application/json" http://localhost:8080/api/books/1 | jq


#############################################
## Delete request to delete books (v5)

# BookService.java

    public boolean deleteBook(Long id) {
        Optional<Book> existingBook = getBookById(id);

        if (existingBook.isPresent()) {
            books.remove(existingBook.get());
            return true;
        }
        return false;
    }


# BookController.java

    @DeleteMapping("{id}")
    public ResponseEntity<?> deleteBook(@PathVariable("id") Long id) {
        boolean isDeleted = bookService.deleteBook(id);

        if (isDeleted) {
            Map<String, String> successResponse = new HashMap<>();
            successResponse.put("message", "Book with ID " + id + " deleted successfully");
            return ResponseEntity.status(HttpStatus.OK).body(successResponse);
        } else {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Book with ID " + id + " not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }

# Make a delete request

curl -X DELETE http://localhost:8080/api/books/1 | jq

curl -X DELETE http://localhost:8080/api/books/2 | jq



















