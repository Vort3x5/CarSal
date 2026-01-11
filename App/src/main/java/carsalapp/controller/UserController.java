package carsalapp.controller;

import carsalapp.dto.KlientContactDto;
import carsalapp.model.Klient;
import carsalapp.service.KlientService;
import carsalapp.service.ModelSamochoduService;
import carsalapp.service.PojazdService;
import carsalapp.service.SalonService;
import jakarta.validation.Valid;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/user")
public class UserController {

    private final KlientService klientService;
    private final PojazdService pojazdService;
    private final ModelSamochoduService modelService;
    private final SalonService salonService;

    public UserController(KlientService klientService,
                          PojazdService pojazdService,
                          ModelSamochoduService modelService,
                          SalonService salonService) {
        this.klientService = klientService;
        this.pojazdService = pojazdService;
        this.modelService = modelService;
        this.salonService = salonService;
    }

    @GetMapping("/profile")
    public String viewProfile(Authentication authentication, Model model) {
        String username = authentication.getName();
        Long klientId = getUserIdFromUsername(username);
        if (klientId == null) {
            model.addAttribute("error", "Nie znaleziono profilu");
            return "error/404";
        }

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
            Klient klient = klientOpt.get();
            if (!model.containsAttribute("contact")) {
                model.addAttribute("contact", new KlientContactDto(klient.getTelefon(), klient.getEmail()));
            }
            return "user/edit";
        } else {
            return "redirect:/user/profile?error=notfound";
        }
    }

    @PostMapping("/update")
    public String updateProfile(@Valid @ModelAttribute("contact") KlientContactDto contact,
                                BindingResult result,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (result.hasErrors()) {
            return "user/edit";
        }

        String username = authentication.getName();
        Long klientId = getUserIdFromUsername(username);
        if (klientId == null) {
            redirectAttributes.addFlashAttribute("error", "Nie znaleziono profilu");
            return "redirect:/user/profile";
        }

        Optional<Klient> existingKlientOpt = klientService.findById(klientId);
        if (existingKlientOpt.isPresent()) {
            Klient existingKlient = existingKlientOpt.get();
            existingKlient.setTelefon(contact.getTelefon());
            existingKlient.setEmail(contact.getEmail());
            klientService.save(existingKlient);
            redirectAttributes.addFlashAttribute("success", "Profil został zaktualizowany");
        }

        return "redirect:/user/profile";
    }

    @GetMapping("/pojazdy")
    public String browsePojazdy(@RequestParam(value = "modelId", required = false) Long modelId,
                                @RequestParam(value = "salonId", required = false) Long salonId,
                                @RequestParam(value = "minRok", required = false) Integer minRok,
                                @RequestParam(value = "maxRok", required = false) Integer maxRok,
                                @RequestParam(value = "minCena", required = false) BigDecimal minCena,
                                @RequestParam(value = "maxCena", required = false) BigDecimal maxCena,
                                @RequestParam(value = "stan", required = false) String stan,
                                Authentication authentication,
                                Model model) {

        Long klientId = getUserIdFromUsername(authentication.getName());
        List<?> pojazdy = pojazdService.findAvailableForClients(modelId, salonId, minRok, maxRok, minCena, maxCena, stan);

        model.addAttribute("pojazdy", pojazdy);
        model.addAttribute("modele", modelService.findAll());
        model.addAttribute("salony", salonService.findAll());
        model.addAttribute("selectedModelId", modelId);
        model.addAttribute("selectedSalonId", salonId);
        model.addAttribute("minRok", minRok);
        model.addAttribute("maxRok", maxRok);
        model.addAttribute("minCena", minCena);
        model.addAttribute("maxCena", maxCena);
        model.addAttribute("stan", stan);
        model.addAttribute("currentUserId", klientId);

        return "user/pojazdy";
    }

    @PostMapping("/pojazdy/reserve/{id}")
    public String reservePojazd(@PathVariable("id") String nrVin,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        Long klientId = getUserIdFromUsername(authentication.getName());
        if (klientId == null) {
            redirectAttributes.addFlashAttribute("error", "Nie znaleziono profilu");
            return "redirect:/user/pojazdy";
        }

        boolean reserved = pojazdService.reserveIfAvailable(nrVin, klientId);
        if (reserved) {
            redirectAttributes.addFlashAttribute("success", "Pojazd został zarezerwowany");
        } else {
            redirectAttributes.addFlashAttribute("error", "Nie można zarezerwować pojazdu");
        }
        return "redirect:/user/pojazdy";
    }

    @PostMapping("/pojazdy/cancel/{id}")
    public String cancelReservation(@PathVariable("id") String nrVin,
                                    Authentication authentication,
                                    RedirectAttributes redirectAttributes) {
        Long klientId = getUserIdFromUsername(authentication.getName());
        if (klientId == null) {
            redirectAttributes.addFlashAttribute("error", "Nie znaleziono profilu");
            return "redirect:/user/pojazdy";
        }

        boolean cancelled = pojazdService.cancelReservation(nrVin, klientId);
        if (cancelled) {
            redirectAttributes.addFlashAttribute("success", "Rezerwacja została anulowana");
        } else {
            redirectAttributes.addFlashAttribute("error", "Nie można anulować rezerwacji");
        }
        return "redirect:/user/pojazdy";
    }

    private Long getUserIdFromUsername(String username) {
        return klientService.findByUsername(username)
            .map(Klient::getNrKlienta)
            .orElse(null);
    }
}
