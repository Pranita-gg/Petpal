package com.petpal.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "pets")
public class Pet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer pet_id;

    @NotNull
    private Integer owner_id;

    @NotBlank
    @Size(max = 50)
    private String name;

    @NotBlank
    @Size(max = 50)
    private String species;

    @Size(max = 50)
    private String breed;

    private Integer age;
    private Double weight;
    private String description;
    private String medical_history;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
} 