package com.skillsoft.springboot.booksrestapi.aspect;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {

    private static final Logger logger = LoggerFactory.getLogger(LoggingAspect.class);

    @Before("execution(* com.skillsoft.springboot.booksrestapi.controller.BookController.*(..))")
    public void logBeforeMethod(JoinPoint joinPoint) {
        logger.info("***** Before executing method: {}", joinPoint.getSignature().getName());
    }

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

    @After("execution(* com.skillsoft.springboot.booksrestapi.controller.BookController.*(..))")
    public void logAfterMethod(JoinPoint joinPoint) {
        logger.info("**********************: \n {} completed", joinPoint.getSignature().getName());
    }
}
