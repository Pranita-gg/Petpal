package model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class Adoption {
    private int adoptionId;
    private int petId;
    private int userId;
    private Timestamp adoptionDate;
    private String paymentStatus;
    private BigDecimal paymentAmount;
    private String status;
    private Pet pet;
    private User user;

    // Default constructor
    public Adoption() {}

    // Constructor with all fields
    public Adoption(int adoptionId, int petId, int userId, Timestamp adoptionDate, 
                   String paymentStatus, BigDecimal paymentAmount) {
        this.adoptionId = adoptionId;
        this.petId = petId;
        this.userId = userId;
        this.adoptionDate = adoptionDate;
        this.paymentStatus = paymentStatus;
        this.paymentAmount = paymentAmount;
    }

    // Getters and Setters
    public int getAdoptionId() {
        return adoptionId;
    }

    public void setAdoptionId(int adoptionId) {
        this.adoptionId = adoptionId;
    }

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

    public Timestamp getAdoptionDate() {
        return adoptionDate;
    }

    public void setAdoptionDate(Timestamp adoptionDate) {
        this.adoptionDate = adoptionDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public BigDecimal getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(BigDecimal paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Pet getPet() {
        return pet;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    // Helper method to check if payment is completed
    public boolean isPaymentCompleted() {
        return "completed".equalsIgnoreCase(this.paymentStatus);
    }
} 