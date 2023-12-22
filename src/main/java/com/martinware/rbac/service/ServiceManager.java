package com.martinware.rbac.service;

import com.martinware.rbac.model.ServiceDto;
import com.martinware.rbac.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceManager {

    @Autowired
    private ServiceRepository repository;

    public ServiceDto saveService(ServiceDto service) {
        return repository.save(service);
    }

    public List<ServiceDto> saveServices(List<ServiceDto> services) {
        return repository.saveAll(services);
    }

    public List<ServiceDto> getServices() {
        return repository.findAll();
    }

    public ServiceDto getServiceById(int id) {
        return repository.findById(id).orElse(null);
    }

    public ServiceDto getServiceByName(String name) {
        return repository.findByName(name);
    }

    public String deleteService(int id) {
        repository.deleteById(id);
        return "Service deleted " + id;
    }

    public ServiceDto updateService(ServiceDto service) {
        ServiceDto existingService = repository.findById(service.getServiceId()).orElse(null);
        assert existingService != null;
        existingService.setName(service.getName());
        return repository.save(existingService);
    }
}
