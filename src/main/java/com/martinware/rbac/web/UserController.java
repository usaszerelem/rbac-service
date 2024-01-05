package com.martinware.rbac.web;

import com.martinware.rbac.model.ServiceDto;
import com.martinware.rbac.model.UserDto;
import com.martinware.rbac.service.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {
    @Autowired
    private UserManager userManager;

    @PostMapping("/user/add")
    public UserDto addService(@RequestBody UserDto user) {
        return userManager.saveUser(user);
    }

    @PostMapping("/user/addMany")
    public List<UserDto> addService(@RequestBody List<UserDto> users) {
        return userManager.saveUsers(users);
    }

    @GetMapping("/users")
    public List<UserDto> findAllUsers() {
        return userManager.getUsers();
    }

    @GetMapping("/user/id/{id}")
    public UserDto findUserById(@PathVariable int id) {
        return userManager.getUserById(id);
    }

    @PutMapping("/user/update")
    public UserDto updateUser(@RequestBody UserDto user) {
        return userManager.updateUser(user);
    }

    @DeleteMapping("/user/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        return userManager.deleteUser(id);
    }
}
