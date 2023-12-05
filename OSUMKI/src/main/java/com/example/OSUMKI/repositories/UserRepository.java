package com.example.OSUMKI.repositories;

import com.example.OSUMKI.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findAllByOrderByRolesAscNameAsc();
    User findByName(String name);
    User findByPhoneNumber(String phoneNumber);
    User findByEmail(String email);
    boolean existsByName(String name);
    boolean existsByEmail(String mail);
    boolean existsByPhoneNumber(String phone);

    @Query("SELECT u FROM User u WHERE u.name LIKE %:searchUser% OR u.email LIKE %:searchUser% OR u.phoneNumber LIKE %:searchUser%")
    List<User> findByNameAndPhoneNumberAndEmail(@Param ("searchUser") String searchUser);

}
