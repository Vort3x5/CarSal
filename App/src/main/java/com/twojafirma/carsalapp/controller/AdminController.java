package com.twojafirma.carsalapp.controller;

import com.twojafirma.carsalapp.model.Klient;
import com.twojafirma.carsalapp.model.Pojazd;
import com.twojafirma.carsalapp.model.ModelSamochodu;
import com.twojafirma.carsalapp.service.KlientService;
import com.twojafirma.carsalapp.service.PojazdService;
import com.twojafirma.carsalapp.service.ModelSamochoduService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private PojazdService pojazdService;

    @Autowired
    private KlientService klientService;

    @Autowired
    private ModelSamochoduService modelService;

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
        return "admin/pojazdy/form";
    }

    @GetMapping("/pojazdy/edit/{id}")
    public String editPojazd(@PathVariable("id") String nrVin, Model model) {
        Optional<Pojazd> pojazdOpt = pojazdService.findById(nrVin);
        if (pojazdOpt.isPresent()) {
            model.addAttribute("pojazd", pojazdOpt.get());
            model.addAttribute("modele", modelService.findAll());
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
            return "admin/pojazdy/form";
        }

        pojazdService.save(pojazd);
        redirectAttributes.addFlashAttribute("success", "Pojazd został zapisany pomyślnie");
        return "redirect:/admin/pojazdy";
    }

    @GetMapping("/pojazdy/delete/{id}")
    public String deletePojazd(@PathVariable("id") String nrVin, RedirectAttributes redirectAttributes) {
        try {
            pojazdService.deleteById(nrVin);
            redirectAttributes.addFlashAttribute("success", "Pojazd został usunięty pomyślnie");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Nie można usunąć pojazdu: " + e.getMessage());
        }
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
