package com.martinware.rbac.repository;

import com.martinware.rbac.model.UserDto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserDto, Integer> {
}
