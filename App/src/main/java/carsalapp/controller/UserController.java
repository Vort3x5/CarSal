package carsalapp.controller;

import carsalapp.model.Klient;
import carsalapp.service.KlientService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private KlientService klientService;

    @GetMapping("/profile")
    public String viewProfile(Authentication authentication, Model model) {
        String username = authentication.getName();

        Long klientId = getUserIdFromUsername(username);
        Optional<Klient> klientOpt = klientService.findById(klientId);

        if (klientOpt.isPresent()) {
            model.addAttribute("klient", klientOpt.get());
            return "user/profile";
        } else {
            model.addAttribute("error", "Nie znaleziono profilu");
            return "error/404";
        }
    }

    @GetMapping("/edit")
    public String editProfile(Authentication authentication, Model model) {
        String username = authentication.getName();
        Long klientId = getUserIdFromUsername(username);

        Optional<Klient> klientOpt = klientService.findById(klientId);
        if (klientOpt.isPresent()) {
            model.addAttribute("klient", klientOpt.get());
            return "user/edit";
        } else {
            return "redirect:/user/profile?error=notfound";
        }
    }

    @PostMapping("/update")
    public String updateProfile(@Valid @ModelAttribute("klient") Klient klient,
                               BindingResult result,
                               Authentication authentication,
                               RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "user/edit";
        }

        String username = authentication.getName();
        Long klientId = getUserIdFromUsername(username);

        Optional<Klient> existingKlientOpt = klientService.findById(klientId);
        if (existingKlientOpt.isPresent()) {
            Klient existingKlient = existingKlientOpt.get();

            existingKlient.setTelefon(klient.getTelefon());
            existingKlient.setEmail(klient.getEmail());
            existingKlient.setUlica(klient.getUlica());
            existingKlient.setMiasto(klient.getMiasto());
            existingKlient.setKodPocztowy(klient.getKodPocztowy());

            klientService.save(existingKlient);
            redirectAttributes.addFlashAttribute("success", "Profil został zaktualizowany");
        }

        return "redirect:/user/profile";
    }

    private Long getUserIdFromUsername(String username) {
        if ("klient1".equals(username)) {
            return 1L;
        } else if ("klient2".equals(username)) {
            return 2L;
        }
        return 1L;
    }
}
