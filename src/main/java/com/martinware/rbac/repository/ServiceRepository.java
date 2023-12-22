package com.martinware.rbac.repository;

import com.martinware.rbac.model.ServiceDto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ServiceRepository extends JpaRepository<ServiceDto, Integer>{

    ServiceDto findByName(String name);
}
