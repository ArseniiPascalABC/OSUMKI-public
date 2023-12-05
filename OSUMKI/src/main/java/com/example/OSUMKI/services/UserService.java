package com.example.OSUMKI.services;

import com.example.OSUMKI.models.Product;
import com.example.OSUMKI.models.User;
import com.example.OSUMKI.models.enums.Role;
import com.example.OSUMKI.repositories.UserRepository;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    public String createUser(User user) {
        System.out.println("Зашли в криате юзер");
        String message = "true";
        if (userRepository.findByName(user.getName()) != null) {
            message = "false username by same";
            System.out.println("Зашли в криате юзер1");
        } else if (user.getName().trim().length() < 5) {
            message = "false username by length";
            System.out.println("Зашли в криате юзер2");
        } else if (userRepository.findByEmail(user.getEmail()) != null) {
            message = "false email";
            System.out.println("Зашли в криате юзер3");
        } else if (userRepository.findByPhoneNumber(user.getPhoneNumber()) != null) {
            message = "false number";
            System.out.println("Зашли в криате юзер4");
        } else if (user.getPassword().trim().length() < 8) {
            message = "false password";
            System.out.println("Зашли в криате юзер5");
        } else {
            user.setActive(true);
            user.setConfirmedEmail(false);
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.getRoles().add(Role.ROLE_USER);
            String email = user.getEmail();
            String phone = user.getPhoneNumber();
            log.info("Saving new User with email: {}", email);
            log.info("Saving new User with phoneNumber: {}", phone);
            String verificationCode = generateVerificationCode();
            System.out.println("Код верификации " + verificationCode);
            user.setVerificationCode(verificationCode);
            System.out.println("Код присвоили");
            userRepository.save(user);
            System.out.println("Юзера записали");
        }
        return message;
    }

    public void sendCode(User user) throws MessagingException {
        String verificationCode = user.getVerificationCode();
        if (emailService.sendVerificationCode(user.getEmail(), verificationCode)) {
            log.info("Код отправили - " + user.getVerificationCode());
        } else {
            log.error("Ошибка отправки кода");
        }
    }

    public List<User> list() {
        return userRepository.findAllByOrderByRolesAscNameAsc();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if ((user != null) && (!user.isAdmin())) {
            if (user.isEnabled()) {
                user.setActive(false);
                log.info("Ban user with id = {}; email: {}", user.getId(), user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unban user with id = {}; email: {}", user.getId(), user.getEmail());
            }
            userRepository.save(user);
        }
    }

    public void confirmUserMail(Long id){
        User user = userRepository.findById(id).orElse(null);
        if ((user != null) && (!user.isAdmin())) {
            if (user.isConfirmedEmail()) {
                user.setConfirmedEmail(false);
                log.info("Ban user with id = {}; email: {}", user.getId(), user.getEmail());
            } else {
                user.setConfirmedEmail(true);
                log.info("Unban user with id = {}; email: {}", user.getId(), user.getEmail());
            }
            userRepository.save(user);
        }
    }

    public void deleteUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if ((user != null) && (!user.isAdmin())) {
            userRepository.deleteById(id);
        }
    }

    public void changeUserInfo(User user, Map<String, String> form, String name, String email, String phonenumber, String verificationCode) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        user.setName(name);
        user.setEmail(email);
        user.setPhoneNumber(phonenumber);
        user.setVerificationCode(verificationCode);
        userRepository.save(user);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public String generateVerificationCode() {
        int length = 6; // Длина кода подтверждения
        String chars = "0123456789"; // Допустимые символы
        Random random = new Random();
        StringBuilder code = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            code.append(chars.charAt(index));
        }

        return code.toString();
    }

    public List<User> listUsers(String searchUser) {
        if ((searchUser != null) && (!searchUser.isEmpty())) {
            searchUser = searchUser.trim();
            return userRepository.findByNameAndPhoneNumberAndEmail(searchUser);
        } else {
            return userRepository.findAll();
        }
    }

}
