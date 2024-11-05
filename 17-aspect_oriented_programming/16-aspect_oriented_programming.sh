######################################## 
demo-16-AspectOrientedProgramming
########################################

# Set up with booksrestapi_starter (this is where we ended the last demo)

# Create a new package 

aspect

# Create a new class 

LoggingAspect.java


package com.skillsoft.springboot.booksrestapi.aspect;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {

    private static final Logger logger = LoggerFactory.getLogger(LoggingAspect.class);

    @Around("execution(* com.skillsoft.springboot.booksrestapi.controller.BookController.*(..))")
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        // Record start time
        long startTime = System.currentTimeMillis();

        // Proceed with the method execution
        Object result = joinPoint.proceed();

        // Calculate time taken
        long timeTaken = System.currentTimeMillis() - startTime;

        // Log after method execution
        logger.info("***** Completed execution of method: {} in {} ms",
                joinPoint.getSignature().getName(), timeTaken);

        return result;
    }
}


---------------------------------------------------

# Log before and after the execution of the method

    @Before("execution(* com.example.package.controller.BookController.*(..))")
    public void logBeforeMethod(JoinPoint joinPoint) {
        logger.info("Before executing method: {}", joinPoint.getSignature().getName());
    }

    @After("execution(* com.skillsoft.springboot.booksrestapi.controller.BookController.*(..))")
    public void logAfterMethod(JoinPoint joinPoint) {
        logger.info("**********************: \n {} completed", joinPoint.getSignature().getName());
    }

# These are the commands to test books (all of these should produce log messages)

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





