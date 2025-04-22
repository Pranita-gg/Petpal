package com.petpal.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer review_id;

    @NotNull
    private Integer user_id;

    @NotNull
    private Integer service_id;

    @NotNull
    @Min(1)
    @Max(5)
    private Integer rating;

    private String comment;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
} 