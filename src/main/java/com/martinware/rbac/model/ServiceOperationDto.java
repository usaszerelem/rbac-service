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
@Table(name = "serviceoperation")
public class ServiceOperationDto {
    @jakarta.persistence.Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="serviceOpId", nullable = false)
    private int serviceOpId;

    @Column(name="serviceId", nullable = false)
    private int serviceId;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "varchar(50) NOT NULL UNIQUE")
    private String name;

    @CreationTimestamp
    private Timestamp createdAt;

    @UpdateTimestamp
    private Timestamp updatedAt;
}
