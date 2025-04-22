package com.petpal.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "appointments")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer appointment_id;

    @NotNull
    private Integer pet_id;

    @NotNull
    private Integer user_id;

    @NotBlank
    @Size(max = 50)
    private String service_type;

    @NotNull
    private LocalDateTime appointment_date;

    @NotBlank
    @Size(max = 20)
    private String status;

    private String notes;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
} 