package com.petpal.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "services")
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer service_id;

    @NotBlank
    @Size(max = 100)
    private String name;

    private String description;

    @NotNull
    private Double price;

    @NotNull
    private Integer duration;

    private LocalDateTime created_at;
    private LocalDateTime updated_at;
} 