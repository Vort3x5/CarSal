package carsalapp.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "SALONY")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Salon {

    @Id
    @Column(name = "nr_salonu")
    private Long nrSalonu;

    @NotBlank(message = "Nazwa salonu jest wymagana")
    @Column(name = "nazwa", length = 100, nullable = false, unique = true)
    private String nazwa;

    @NotBlank(message = "Ulica jest wymagana")
    @Column(name = "ulica", length = 100, nullable = false)
    private String ulica;

    @NotBlank(message = "Miasto jest wymagane")
    @Column(name = "miasto", length = 50, nullable = false)
    private String miasto;

    @NotBlank(message = "Kod pocztowy jest wymagany")
    @Column(name = "kod_pocztowy", length = 6, nullable = false)
    private String kodPocztowy;

    @Column(name = "telefon", length = 15)
    private String telefon;

    @Column(name = "email", length = 100)
    private String email;

    public String getFullAddress() {
        return ulica + ", " + kodPocztowy + " " + miasto;
    }

    public String getDisplayName() {
        return nazwa + " - " + miasto;
    }
}
