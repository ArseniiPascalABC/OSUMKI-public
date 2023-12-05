package com.example.OSUMKI.controllers;


import com.example.OSUMKI.models.User;
import com.example.OSUMKI.models.enums.Role;
import com.example.OSUMKI.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {
    private final UserService userService;

    @GetMapping("/admin")
    public String admin(@RequestParam(name = "searchUser", required = false) String searchUser, Model model, Principal principal) {
        if (searchUser!=null){
            model.addAttribute("users", userService.listUsers(searchUser));
            model.addAttribute("searchUser", searchUser);
        }
        else {
            model.addAttribute("users", userService.list());
        }
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin";
    }

    @PostMapping("/admin/user/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return "redirect:/admin";
    }

    @PostMapping("/admin/user/confirmEmail/{id}")
    public String confirmUserEmail(@PathVariable Long id) {
        userService.confirmUserMail(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("userEdit", user);
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam Map<String, String> form,
                           @RequestParam("name") String name, @RequestParam("email") String email,
                           @RequestParam("phoneNumber") String phoneNumber, @RequestParam("verificationCode") String verificationCode) {
        userService.changeUserInfo(user, form, name, email, phoneNumber, verificationCode);
        return "redirect:/admin";
    }

}
