package carsalapp.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "KLIENCI")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Klient {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "klient_seq")
    @SequenceGenerator(name = "klient_seq", sequenceName = "SEQ_KLIENCI", allocationSize = 1)
    @Column(name = "nr_klienta")
    private Long nrKlienta;

    @NotBlank(message = "Nazwa użytkownika jest wymagana")
    @Column(name = "username", length = 50, nullable = false, unique = true)
    private String username;

    @NotBlank(message = "Hasło jest wymagane")
    @Column(name = "password_hash", length = 255, nullable = false)
    private String passwordHash;

    @NotBlank(message = "Rola jest wymagana")
    @Column(name = "rola", length = 20, nullable = false)
    private String rola;

    @Column(name = "enabled", nullable = false)
    private boolean enabled = true;

    @NotBlank(message = "Typ klienta jest wymagany")
    @Column(name = "typ_klienta", length = 15, nullable = false)
    private String typKlienta;

    @Column(name = "imie", length = 50)
    private String imie;

    @Column(name = "nazwisko", length = 50)
    private String nazwisko;

    @Pattern(regexp = "\\d{11}", message = "PESEL musi składać się z 11 cyfr")
    @Column(name = "pesel", length = 11, unique = true)
    private String pesel;

    @Column(name = "nazwa_firmy", length = 100)
    private String nazwaFirmy;

    @Pattern(regexp = "\\d{10}", message = "NIP musi składać się z 10 cyfr")
    @Column(name = "nip", length = 10, unique = true)
    private String nip;

    @Column(name = "ulica", length = 100)
    private String ulica;

    @Column(name = "miasto", length = 50)
    private String miasto;

    @Column(name = "kod_pocztowy", length = 6)
    private String kodPocztowy;

    @NotBlank(message = "Telefon jest wymagany")
    @Pattern(regexp = "[0-9\\- ]{7,15}", message = "Telefon musi mieć 7-15 cyfr i może zawierać myślniki lub spacje")
    @Column(name = "telefon", length = 15, nullable = false)
    private String telefon;

    @Email(message = "Nieprawidłowy format email")
    @Column(name = "email", length = 100, unique = true)
    private String email;

    @Column(name = "data_rejestracji")
    private LocalDate dataRejestracji;

    public String getDisplayName() {
        if ("Indywidualny".equals(typKlienta)) {
            return imie + " " + nazwisko;
        } else {
            return nazwaFirmy;
        }
    }
}
