package com.skillsoft.springboot.controller;

import com.skillsoft.springboot.model.Car;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;
import java.util.List;

@Controller
public class SimpleController {

    @GetMapping("/cars")
    public String showCars(Model model) {
        List<Car> cars = Arrays.asList(
                new Car("Tesla Model 3", "Electric", 2022),
                new Car("Ford Mustang", "Gasoline", 2020),
                new Car("Chevrolet Camaro", "Gasoline", 2021)
        );

        model.addAttribute("cars", cars);
        model.addAttribute("isLoggedIn", false);

        return "index";
    }
}