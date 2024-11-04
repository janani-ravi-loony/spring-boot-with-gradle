package com.skillsoft.springboot;

public class Engine {
    private final String type;

    public Engine(String type) {
        System.out.println("Constructing engine with type: " + type);
        this.type = type;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "Engine{" +
                "type=" + type +
                '}';
    }
}