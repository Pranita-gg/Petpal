package com.petrental.model;

import java.util.Date;

public class Pet {
    private int id;
    private String name;
    private String species;
    private String breed;
    private int age;
    private String description;
    private double rentalPrice;
    private boolean isAvailable;
    private byte[] petImage;
    private Date createdAt;
    private Date updatedAt;

    // Default constructor
    public Pet() {
    }

    // Constructor with all fields
    public Pet(int id, String name, String species, String breed, int age, String description, 
               double rentalPrice, boolean isAvailable, byte[] petImage, Date createdAt, Date updatedAt) {
        this.id = id;
        this.name = name;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.description = description;
        this.rentalPrice = rentalPrice;
        this.isAvailable = isAvailable;
        this.petImage = petImage;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getRentalPrice() {
        return rentalPrice;
    }

    public void setRentalPrice(double rentalPrice) {
        this.rentalPrice = rentalPrice;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public byte[] getPetImage() {
        return petImage;
    }

    public void setPetImage(byte[] petImage) {
        this.petImage = petImage;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
} 