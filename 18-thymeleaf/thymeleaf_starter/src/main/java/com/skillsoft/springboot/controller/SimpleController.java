package com.skillsoft.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SimpleController {

    @GetMapping("/")
    public String hello(Model model) {
        model.addAttribute("message", "Hello, Thymeleaf!");

        return "index";
    }
}