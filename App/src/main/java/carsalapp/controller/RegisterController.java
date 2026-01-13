package carsalapp.controller;

import carsalapp.dto.RegistrationDto;
import carsalapp.model.Klient;
import carsalapp.service.KlientService;
import jakarta.validation.Valid;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
public class RegisterController {

    private final KlientService klientService;
    private final PasswordEncoder passwordEncoder;

    public RegisterController(KlientService klientService, PasswordEncoder passwordEncoder) {
        this.klientService = klientService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        if (!model.containsAttribute("form")) {
            model.addAttribute("form", new RegistrationDto());
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("form") RegistrationDto form,
                           BindingResult result,
                           RedirectAttributes redirectAttributes) {

        if (klientService.findByUsername(form.getUsername()).isPresent()) {
            result.rejectValue("username", "username.exists", "Taki login już istnieje");
        }

        if (!form.getPassword().equals(form.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "password.mismatch", "Hasła muszą być identyczne");
        }

        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.form", result);
            redirectAttributes.addFlashAttribute("form", form);
            return "redirect:/register";
        }

        Klient klient = new Klient();
        klient.setUsername(form.getUsername());
        klient.setPasswordHash(passwordEncoder.encode(form.getPassword()));
        klient.setRola("USER");
        klient.setEnabled(true);

        klient.setTypKlienta("Firma");
        klient.setNip(generateNip());
        klient.setNazwaFirmy("Klient " + form.getUsername());

        klient.setTelefon("000000000");
        klient.setDataRejestracji(LocalDate.now());

        klientService.save(klient);

        redirectAttributes.addFlashAttribute("message", "Konto utworzone. Zaloguj się.");
        return "redirect:/login";
    }

    private String generateNip() {
        long ts = System.currentTimeMillis() % 1_000_000_0000L;
        return String.format("%010d", ts);
    }
}
