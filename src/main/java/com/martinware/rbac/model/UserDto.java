package com.martinware.rbac.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "user")
public class UserDto {

    @jakarta.persistence.Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="userId", nullable = false)
    private int userId;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "tinyint NOT NULL DEFAULT '1'")
    private Boolean isActive;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "tinyint NOT NULL DEFAULT '1'")
    private Boolean enableAudit;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "varchar(25) NOT NULL")
    private String fname;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "varchar(45) NOT NULL")
    private String lname;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "varchar(100) NOT NULL UNIQUE")
    private String email;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "varchar(255) NOT NULL")
    private String password;

    @CreationTimestamp
    private Timestamp createdAt;

    @UpdateTimestamp
    private Timestamp updatedAt;
}
