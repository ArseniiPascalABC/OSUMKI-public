package com.example.OSUMKI.models;

import com.example.OSUMKI.models.enums.Role;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name = "users")
@Data
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "phoneNumber", unique = true)
    private String phoneNumber;
    @Column(name = "email", unique = true)
    private String email;
    @Column(name = "active")
    private boolean active;
    @Column(name = "password", length = 1000)
    private String password;
    @Column(name = "confirmedEmail")
    private boolean confirmedEmail;
    @Column(name = "verificationCode")
    private String verificationCode;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = new HashSet<>();
    private LocalDateTime dateOfCreated;
    @PrePersist
    private void init(){
        dateOfCreated = LocalDateTime.now();
    }

    public boolean isAdmin(){
        return roles.contains(Role.ROLE_ADMIN);
    }
    public boolean isModerator(){
        return roles.contains(Role.ROLE_MODERATOR);
    }
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return active;
    }

//    public boolean isConfirmedEmail() {
//        return confirmedEmail;
//    }
    public String stringActive(){
        return String.valueOf(active);
    }

}
