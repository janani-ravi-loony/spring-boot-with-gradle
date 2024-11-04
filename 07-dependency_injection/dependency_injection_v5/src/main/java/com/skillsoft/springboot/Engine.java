package com.skillsoft.springboot;

public class Engine {
    private final String type;

    public Engine(String type) {
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