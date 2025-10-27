package com.twojafirma.carsalapp.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Authentication authentication, Model model) {
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("username", authentication.getName());
            
            if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
                model.addAttribute("role", "Administrator");
                model.addAttribute("isAdmin", true);
            } else {
                model.addAttribute("role", "Klient");
                model.addAttribute("isAdmin", false);
            }
        }
        return "home";
    }

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                       @RequestParam(value = "logout", required = false) String logout,
                       Model model) {
        if (error != null) {
            model.addAttribute("error", "Nieprawidłowa nazwa użytkownika lub hasło");
        }
        if (logout != null) {
            model.addAttribute("message", "Wylogowano pomyślnie");
        }
        return "login";
    }

    @GetMapping("/error/403")
    public String accessDenied(Model model) {
        model.addAttribute("errorMessage", "Nie masz uprawnień do tej strony");
        return "error/403";
    }
}
