package com.petpal.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer user_id;

    @NotBlank
    @Size(max = 50)
    @Column(nullable = false, unique = true)
    private String username;

    @NotBlank
    @Email
    @Size(max = 100)
    @Column(nullable = false, unique = true)
    private String email;

    @NotBlank
    @Size(min = 8)
    @Column(nullable = false)
    private String password_hash;

    @Size(max = 50)
    private String first_name;

    @Size(max = 50)
    private String last_name;

    @Size(max = 20)
    private String phone_number;

    private String address;

    private LocalDateTime created_at;
    private LocalDateTime updated_at;
} 