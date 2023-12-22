package com.martinware.rbac.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "service")
public class ServiceDto {

    @jakarta.persistence.Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="serviceId", nullable = false)
    private int serviceId;

    @NotEmpty
    @Column(nullable = false, columnDefinition = "varchar(50) UNIQUE")
    private String name;

    @Column(updatable=false, insertable=false)
    @Temporal(TemporalType.TIMESTAMP)
    private Timestamp createdAt;

    @Column(updatable=false, insertable=false)
    @Temporal(TemporalType.TIMESTAMP)
    private Timestamp updatedAt;
}
