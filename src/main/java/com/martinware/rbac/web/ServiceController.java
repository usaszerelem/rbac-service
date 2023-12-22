package com.martinware.rbac.web;

import com.martinware.rbac.model.ServiceDto;
import com.martinware.rbac.service.ServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ServiceController {
    @Autowired
    private ServiceManager serviceManager;

    @PostMapping("/service/add")
    public ServiceDto addService(@RequestBody ServiceDto serviceDto) {
        return serviceManager.saveService(serviceDto);
    }

    @PostMapping("/service/addMany")
    public List<ServiceDto> addServices(@RequestBody List<ServiceDto> serviceDtos) {
        return serviceManager.saveServices(serviceDtos);
    }

    @GetMapping("/services")
    public List<ServiceDto> findAllProducts() {
        return serviceManager.getServices();
    }

    @GetMapping("/service/id/{id}")
    public ServiceDto findServiceById(@PathVariable int id) {
        return serviceManager.getServiceById(id);
    }

    @GetMapping("/service/name/{name}")
    public ServiceDto findServiceByName(@PathVariable String name) {
        return serviceManager.getServiceByName(name);
    }

    @PutMapping("/service/update")
    public ServiceDto updateService(@RequestBody ServiceDto serviceDto) {
        return serviceManager.updateService(serviceDto);
    }

    @DeleteMapping("/service/delete/{id}")
    public String deleteService(@PathVariable int id) {
        return serviceManager.deleteService(id);
    }
}
