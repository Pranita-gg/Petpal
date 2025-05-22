package model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class Pet {
    private int petId;
    private int userId;
    private String name;
    private String species;
    private String breed;
    private Integer age;
    private BigDecimal price;
    private String description;
    private String petImage;
    private String status;
    private Timestamp createdAt;
    private byte[] imageData;
    private String imageType;

    // Default constructor
    public Pet() {}

    // Constructor with all fields
    public Pet(int petId, int userId, String name, String species, String breed, 
               Integer age, BigDecimal price, String description, String petImage, 
               String status, Timestamp createdAt) {
        this.petId = petId;
        this.userId = userId;
        this.name = name;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.price = price;
        this.description = description;
        this.petImage = petImage;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getPetId() {
        return petId;
    }

    public void setPetId(int petId) {
        this.petId = petId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPetImage() {
        return petImage;
    }

    public void setPetImage(String petImage) {
        this.petImage = petImage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public String getImageType() {
        return imageType;
    }

    public void setImageType(String imageType) {
        this.imageType = imageType;
    }

    // Helper method to check if pet is available
    public boolean isAvailable() {
        return "available".equalsIgnoreCase(this.status);
    }
} 