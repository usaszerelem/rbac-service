package com.martinware.rbac.service;

import com.martinware.rbac.model.ServiceDto;
import com.martinware.rbac.model.UserDto;
import com.martinware.rbac.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserManager {
    @Autowired
    private UserRepository repository;

    public UserDto saveUser(UserDto user) {
        return repository.save(user);
    }

    public List<UserDto> saveUsers(List<UserDto> users) {
        return repository.saveAll(users);
    }

    public List<UserDto> getUsers() {
        return repository.findAll();
    }

    public UserDto getUserById(int id) {
        return repository.findById(id).orElse(null);
    }

    public String deleteUser(int id) {
        repository.deleteById(id);
        return "User deleted: " + id;
    }

    public UserDto updateUser(UserDto user) {
        UserDto existingUser = repository.findById(user.getUserId()).orElse(null);
        assert existingUser != null;

        existingUser.setIsActive(user.getIsActive());
        existingUser.setEnableAudit(user.getEnableAudit());
        existingUser.setFname(user.getFname());
        existingUser.setLname(user.getLname());
        existingUser.setEmail(user.getEmail());
        existingUser.setPassword(user.getPassword());

        return repository.save(existingUser);
    }
}
