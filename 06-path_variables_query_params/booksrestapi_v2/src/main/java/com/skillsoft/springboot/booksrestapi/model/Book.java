package com.skillsoft.springboot.booksrestapi.model;

public class Book {
    private Long id;
    private String title;
    private String author;
    private String releaseDate;
    private String blurb;
    private String category;

    public Book(Long id, String title, String author, String releaseDate, String blurb, String category) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.releaseDate = releaseDate;
        this.blurb = blurb;
        this.category = category;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }

    public String getBlurb() { return blurb; }
    public void setBlurb(String blurb) { this.blurb = blurb; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}