package com.martinware.rbac.service;

import com.martinware.rbac.model.ServiceDto;
import com.martinware.rbac.model.ServiceOperationDto;
import com.martinware.rbac.repository.ServiceOperationRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceOperationManager {
    @Autowired
    private ServiceOperationRepository repository;

    public ServiceOperationDto saveServiceOperation(ServiceOperationDto serviceOp) {
        return repository.save(serviceOp);
    }

    public List<ServiceOperationDto> saveServiceOperations(List<ServiceOperationDto> serviceOps) {
        return repository.saveAll(serviceOps);
    }

    public List<ServiceOperationDto> getServiceOperations() {
        return repository.findAll();
    }

    public ServiceOperationDto getServiceOperationById(int id) {
        return repository.findById(id).orElse(null);
    }

    public ServiceOperationDto getServiceOperationByName(String name) {
        return repository.findByName(name);
    }

    public String deleteServiceOperation(int id) {
        repository.deleteById(id);
        return "Service Operation deleted: " + id;
    }

    public ServiceOperationDto updateServiceOperation(ServiceOperationDto serviceOp) {
        ServiceOperationDto existingServiceOp = repository.findById(serviceOp.getServiceOpId()).orElse(null);
        assert existingServiceOp != null;
        existingServiceOp.setName(serviceOp.getName());
        return repository.save(existingServiceOp);
    }
}
