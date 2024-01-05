package com.martinware.rbac.repository;

import com.martinware.rbac.model.ServiceOperationDto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ServiceOperationRepository extends JpaRepository<ServiceOperationDto, Integer> {
    ServiceOperationDto findByName(String name);
}
