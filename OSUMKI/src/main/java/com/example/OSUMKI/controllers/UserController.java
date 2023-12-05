package com.example.OSUMKI.controllers;

import com.example.OSUMKI.models.User;
import com.example.OSUMKI.repositories.UserRepository;
import com.example.OSUMKI.services.ProductService;
import com.example.OSUMKI.services.UserService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final ProductService productService;
    private final UserRepository userRepository;

    @GetMapping("/login")
    public String login(Model model, Principal principal, @RequestParam(name = "error", required = false) String error, @RequestParam(name = "logout", required = false) String logout) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        if (error != null) {
            model.addAttribute("errorMessage", "Неверный логин или пароль");
        }
        else if(logout != null){
            model.addAttribute("errorMessage", "Успешный выход");
        }
        return "login";
    }
    @GetMapping("/registration")
    public String registration(Model model, Principal principal, HttpSession session) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(User user, Model model, HttpSession session) {
        model.addAttribute("user", user);
        session.setAttribute("successMessage", "Успешная регистрация");
        String message = userService.createUser(user);
        if(message.equals("true")){
            return "redirect:/login";
        }
        else {
            model.addAttribute("errorMessage", "ошибка");
            return "registration";
        }
    }
    @GetMapping("/check-username")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkUsername(@RequestParam String name) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", userRepository.existsByName(name));
        return ResponseEntity.ok(response);
    }

    @GetMapping("/check-mail")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkMail(@RequestParam String mail) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", userRepository.existsByEmail(mail));
        return ResponseEntity.ok(response);
    }

    @GetMapping("/check-phone")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkPhone(@RequestParam String phone) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", userRepository.existsByPhoneNumber(phone));
        return ResponseEntity.ok(response);
    }

    @GetMapping("/confirm")
    public String confirm(Model model, Principal principal) throws MessagingException {
        User user = userService.getUserByPrincipal(principal);
        if (user.isConfirmedEmail()) {
            return "redirect:profile";
        } else {
            userService.sendCode(user);
            model.addAttribute("user", user);
            return "confirm";
        }
    }



    @PostMapping("/confirm")
    public String confirmEmail(@RequestParam("confirmationCode") String confirmationCode, Model model, Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        if (Objects.equals(user.getVerificationCode(), confirmationCode.trim())) {
            model.addAttribute("errormessage", "Почта успешно подтверждена!");
            user.setConfirmedEmail(true);
            userRepository.save(user);
            return "redirect:/profile";
        } else {
            model.addAttribute("errormessage", "Неверный код");
            return "confirm";
        }
    }

    @ModelAttribute("brands")
    public List<String> getAllBrands() {
        return productService.getAllBrands();
    }

    @ModelAttribute("titles")
    public List<String> getAllTitles() {
        return productService.getAllTitles();
    }

    @ModelAttribute("materials")
    public List<String> getAllMaterials() {
        return productService.getAllMaterials();
    }

    @ModelAttribute("sizes")
    public List<String> getAllSizes() {
        return productService.getAllSizes();
    }

    @GetMapping("/profile")
    public String profile(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/About")
    public String about(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        return "About";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("user", user);
        model.addAttribute("userByPrincipal", userService.getUserByPrincipal(principal));
        return "user-info";
    }
}

