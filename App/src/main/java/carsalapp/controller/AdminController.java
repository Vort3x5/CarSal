package carsalapp.controller;

import carsalapp.model.Klient;
import carsalapp.model.Pojazd;
import carsalapp.service.KlientService;
import carsalapp.service.ModelSamochoduService;
import carsalapp.service.PojazdService;
import carsalapp.service.SalonService;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final PojazdService pojazdService;
    private final KlientService klientService;
    private final ModelSamochoduService modelService;
    private final SalonService salonService;

    public AdminController(PojazdService pojazdService,
                           KlientService klientService,
                           ModelSamochoduService modelService,
                           SalonService salonService) {
        this.pojazdService = pojazdService;
        this.klientService = klientService;
        this.modelService = modelService;
        this.salonService = salonService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        long totalPojazdy = pojazdService.findAll().size();
        long totalKlienci = klientService.findAll().size();

        model.addAttribute("totalPojazdy", totalPojazdy);
        model.addAttribute("totalKlienci", totalKlienci);

        return "admin/dashboard";
    }

    @GetMapping("/pojazdy")
    public String listPojazdy(Model model) {
        List<Pojazd> pojazdy = pojazdService.findAll();
        model.addAttribute("pojazdy", pojazdy);
        return "admin/pojazdy/list";
    }

    @GetMapping("/pojazdy/new")
    public String newPojazd(Model model) {
        model.addAttribute("pojazd", new Pojazd());
        model.addAttribute("modele", modelService.findAll());
        model.addAttribute("salony", salonService.findAll());
        return "admin/pojazdy/form";
    }

    @GetMapping("/pojazdy/edit/{id}")
    public String editPojazd(@PathVariable("id") String nrVin, Model model) {
        Optional<Pojazd> pojazdOpt = pojazdService.findById(nrVin);
        if (pojazdOpt.isPresent()) {
            model.addAttribute("pojazd", pojazdOpt.get());
            model.addAttribute("modele", modelService.findAll());
            model.addAttribute("salony", salonService.findAll());
            return "admin/pojazdy/form";
        } else {
            return "redirect:/admin/pojazdy?error=notfound";
        }
    }

    @PostMapping("/pojazdy/save")
    public String savePojazd(@Valid @ModelAttribute("pojazd") Pojazd pojazd,
                             BindingResult result,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("modele", modelService.findAll());
            model.addAttribute("salony", salonService.findAll());
            return "admin/pojazdy/form";
        }

        pojazdService.save(pojazd);
        redirectAttributes.addFlashAttribute("success", "Pojazd został zapisany pomyślnie");
        return "redirect:/admin/pojazdy";
    }

    @PostMapping("/pojazdy/delete/{id}")
    public String deletePojazd(@PathVariable("id") String nrVin, RedirectAttributes redirectAttributes) {
        Optional<Pojazd> pojazdOpt = pojazdService.findById(nrVin);
        if (pojazdOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Pojazd nie istnieje");
            return "redirect:/admin/pojazdy";
        }

        pojazdService.softDeleteById(nrVin);
        redirectAttributes.addFlashAttribute("success", "Pojazd został oznaczony jako usunięty");
        return "redirect:/admin/pojazdy";
    }

    @GetMapping("/klienci")
    public String listKlienci(Model model) {
        List<Klient> klienci = klientService.findAll();
        model.addAttribute("klienci", klienci);
        return "admin/klienci/list";
    }

    @GetMapping("/klienci/view/{id}")
    public String viewKlient(@PathVariable("id") Long id, Model model) {
        Optional<Klient> klientOpt = klientService.findById(id);
        if (klientOpt.isPresent()) {
            model.addAttribute("klient", klientOpt.get());
            return "admin/klienci/view";
        } else {
            return "redirect:/admin/klienci?error=notfound";
        }
    }
}
