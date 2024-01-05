package com.martinware.rbac.web;

import com.martinware.rbac.model.ServiceDto;
import com.martinware.rbac.model.ServiceOperationDto;
import com.martinware.rbac.model.UserDto;
import com.martinware.rbac.service.ServiceOperationManager;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ServiceOperationController {
    @Autowired
    private ServiceOperationManager manager;

    /**
     * Adds a new service operation that an existing service can perform.
     * As an example an 'Activitu Log' service can 'Display Logs'. In the
     * Below example the 'Activitu Log' service has a serviceId of 2.
     *
     * @param serviceOperationDto
     * {
     *     "serviceId": 2,
     *     "name": "Display Logs"
     * }
     * @return
     * {
     *     "serviceOpId": 10,
     *     "serviceId": 2,
     *     "name": "Display Logs",
     *     "createdAt": "2024-01-05T03:57:43.611+00:00",
     *     "updatedAt": "2024-01-05T03:57:43.611+00:00"
     * }
     */
    @PostMapping("/serviceoperation/add")
    public ServiceOperationDto addService(@RequestBody ServiceOperationDto serviceOperationDto) {
        return manager.saveServiceOperation(serviceOperationDto);
    }

    /**
     * Adds several service operations to an existing service. This
     * call can be used after a service was crated to associate additional
     * operations with it. As an example an existing service exposes two
     * additional operations that it did not have before. Instead of making
     * several '/serviceoperation/add' calls, just make one call with all
     * additional service operations.
     * As an example an 'Activitu Log' service can exposes two additional
     * operations call 'Display Logs' and 'Delete Logs'. These two operations
     * are added with one call.
     * In the below example the 'Activitu Log' service has a serviceId of 2.
     *
     * IMPORTANT: Name of the service operation must be unique!
     *
     * @param serviceOperationDtos
     * [
     *     {
     *     "serviceId": 2,
     *     "name": "Display Logs"
     *     },
     *     {
     *     "serviceId": 2,
     *     "name": "Delete Logs"
     *     }
     * ]
     * @return
     * [
     *     {
     *         "serviceOpId": 13,
     *         "serviceId": 2,
     *         "name": "Display Logs",
     *         "createdAt": "2024-01-05T04:12:04.521+00:00",
     *         "updatedAt": "2024-01-05T04:12:04.521+00:00"
     *     },
     *     {
     *         "serviceOpId": 14,
     *         "serviceId": 2,
     *         "name": "Delete Logs",
     *         "createdAt": "2024-01-05T04:12:04.525+00:00",
     *         "updatedAt": "2024-01-05T04:12:04.525+00:00"
     *     }
     * ]
     */
    @PostMapping("/serviceoperation/addMany")
    public List<ServiceOperationDto> addServices(@RequestBody List<ServiceOperationDto> serviceOperationDtos) {
        return manager.saveServiceOperations(serviceOperationDtos);
    }

    /**
     * Returns all service operations for all services.
     * @return
     * [
     *     {
     *         "serviceOpId": 1,
     *         "serviceId": 1,
     *         "name": "View Logs",
     *         "createdAt": "2023-12-18T05:54:53.000+00:00",
     *         "updatedAt": "2023-12-18T05:54:53.000+00:00"
     *     },
     *     {
     *         "serviceOpId": 2,
     *         "serviceId": 1,
     *         "name": "Delete Logs",
     *         "createdAt": "2023-12-18T05:55:04.000+00:00",
     *         "updatedAt": "2023-12-18T05:55:04.000+00:00"
     *     },
     *     {
     *         "serviceOpId": 3,
     *         "serviceId": 2,
     *         "name": "Abc Op 1",
     *         "createdAt": "2024-01-05T02:08:51.000+00:00",
     *         "updatedAt": "2024-01-05T02:08:51.000+00:00"
     *     },
     *     {
     *         "serviceOpId": 4,
     *         "serviceId": 2,
     *         "name": "Abc Op 2",
     *         "createdAt": "2024-01-05T02:08:51.000+00:00",
     *         "updatedAt": "2024-01-05T02:08:51.000+00:00"
     *     }
     * ]
     */
    @GetMapping("/serviceoperations")
    public List<ServiceOperationDto> getServiceOperations() {
        return manager.getServiceOperations();
    }

    /**
     * This endpoint returns one specific service operations for a
     * service. The unique service operation ID must be provided
     * @param id - Unique service operation ID. As an example 7
     * @return
     * {
     *     "serviceOpId": 7,
     *     "serviceId": 2,
     *     "name": "Display Logs",
     *     "createdAt": "2024-01-05T02:23:47.000+00:00",
     *     "updatedAt": "2024-01-05T02:23:47.000+00:00"
     * }
     */
    @GetMapping("/serviceoperation/id/{id}")
    public ServiceOperationDto getServiceOperationById(@PathVariable int id) {
        return manager.getServiceOperationById(id);
    }

    /**
     * This endpoint returns one specific service operation for a
     * service. The unique service operation name is used for this
     * endpoint. As en example 'Display%20Logs'.
     *
     * @param name - 'Display%20Logs'
     * @return
     * {
     *     "serviceOpId": 7,
     *     "serviceId": 2,
     *     "name": "Display Logs",
     *     "createdAt": "2024-01-05T02:23:47.000+00:00",
     *     "updatedAt": "2024-01-05T02:23:47.000+00:00"
     * }
     */
    @GetMapping("/serviceoperation/name/{name}")
    public ServiceOperationDto getServiceOperationByName(@PathVariable String name) {
        return manager.getServiceOperationByName(name);
    }

    /**
     * Updates the user friendly name of a specific service operation
     * @param serviceOp - In Body of the request
     * {
     *     "serviceOpId": 7,
     *     "name": "Display Activity Logs"
     * }
     * @return
     * {
     *     "serviceOpId": 7,
     *     "serviceId": 2,
     *     "name": "Display Activity Logs",
     *     "createdAt": "2024-01-05T02:23:47.000+00:00",
     *     "updatedAt": "2024-01-05T02:23:47.000+00:00"
     * }
     */
    @PutMapping("/serviceoperation/update")
    public ServiceOperationDto updateServiceOperation(@RequestBody ServiceOperationDto serviceOp) {
        return manager.updateServiceOperation(serviceOp);
    }

    /**
     * Deletes a specific service operation using its unique ID number.
     * @param id - As an example 7
     * @return - Service Operation deleted: 7
     */
    @DeleteMapping("/serviceoperation/delete/{id}")
    public String deleteServiceOperation(@PathVariable int id) {
        return manager.deleteServiceOperation(id);
    }
}
