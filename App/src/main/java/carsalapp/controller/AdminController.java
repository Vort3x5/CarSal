package carsalapp.controller;

import carsalapp.model.Klient;
import carsalapp.model.Pojazd;
import carsalapp.service.KlientService;
import carsalapp.service.ModelSamochoduService;
import carsalapp.service.PojazdService;
import carsalapp.service.SalonService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
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
    public String listPojazdy(@RequestParam(value = "page", defaultValue = "0") int page,
                             @RequestParam(value = "size", defaultValue = "10") int size,
                             @RequestParam(value = "search", required = false) String search,
                             Model model) {
        
        Pageable pageable = PageRequest.of(page, size, Sort.by("rokProdukcji").descending());
        Page<Pojazd> pojazdyPage = pojazdService.findAllPaginated(search, pageable);
        
        model.addAttribute("pojazdy", pojazdyPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pojazdyPage.getTotalPages());
        model.addAttribute("totalElements", pojazdyPage.getTotalElements());
        model.addAttribute("pageSize", size);
        model.addAttribute("searchTerm", search);
        
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

        try {
            pojazdService.save(pojazd);
            redirectAttributes.addFlashAttribute("success", "Pojazd został zapisany pomyślnie");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Błąd podczas zapisywania pojazdu: " + e.getMessage());
        }
        
        return "redirect:/admin/pojazdy";
    }

    @PostMapping("/pojazdy/delete/{id}")
    public String deletePojazd(@PathVariable("id") String nrVin, RedirectAttributes redirectAttributes) {
        Optional<Pojazd> pojazdOpt = pojazdService.findById(nrVin);
        if (pojazdOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Pojazd nie istnieje");
            return "redirect:/admin/pojazdy";
        }

        try {
            pojazdService.softDeleteById(nrVin);
            redirectAttributes.addFlashAttribute("success", "Pojazd został oznaczony jako usunięty");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Błąd podczas usuwania pojazdu: " + e.getMessage());
        }
        
        return "redirect:/admin/pojazdy";
    }

    @GetMapping("/klienci")
    public String listKlienci(@RequestParam(value = "page", defaultValue = "0") int page,
                             @RequestParam(value = "size", defaultValue = "15") int size,
                             Model model) {
        
        Pageable pageable = PageRequest.of(page, size, Sort.by("dataRejestracji").descending());
        Page<Klient> klienciPage = klientService.findAllPaginated(pageable);
        
        model.addAttribute("klienci", klienciPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", klienciPage.getTotalPages());
        model.addAttribute("totalElements", klienciPage.getTotalElements());
        model.addAttribute("pageSize", size);
        
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
