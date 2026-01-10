package carsalapp.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "POJAZDY")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pojazd {

    @Id
    @Column(name = "nr_vin", length = 17)
    @NotBlank(message = "Numer VIN jest wymagany")
    private String nrVin;

    @NotNull(message = "Model jest wymagany")
    @Column(name = "id_modelu", nullable = false)
    private Long idModelu;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_modelu", referencedColumnName = "id_modelu", insertable = false, updatable = false)
    private ModelSamochodu model;

    @NotNull(message = "Salon jest wymagany")
    @Column(name = "nr_salonu", nullable = false)
    private Long nrSalonu;

    @NotNull(message = "Rok produkcji jest wymagany")
    @Column(name = "rok_produkcji", nullable = false)
    private Integer rokProdukcji;

    @Column(name = "przebieg")
    private Integer przebieg;

    @Column(name = "kolor", length = 30)
    private String kolor;

    @NotNull(message = "Cena katalogowa jest wymagana")
    @Column(name = "cena_katalogowa", precision = 10, scale = 2, nullable = false)
    private BigDecimal cenaKatalogowa;

    @NotBlank(message = "Stan jest wymagany")
    @Column(name = "stan", length = 10, nullable = false)
    private String stan;

    @NotBlank(message = "Status jest wymagany")
    @Column(name = "status", length = 15, nullable = false)
    private String status;

    @Column(name = "data_przyjecia")
    private LocalDate dataPrzyjecia;

    @Column(name = "uwagi", length = 500)
    private String uwagi;

    @Column(name = "deleted", nullable = false)
    private boolean deleted = false;

    @Column(name = "nr_klienta_rezerwujacego")
    private Long nrKlientaRezerwujacego;

    public String getFullDescription() {
        return (model != null ? model.getNazwaModelu() : "Nieznany model") +
               " (" + rokProdukcji + ", " + kolor + ")";
    }
}
