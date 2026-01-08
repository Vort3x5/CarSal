package carsalapp.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "MODELE_SAMOCHODOW")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ModelSamochodu {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "model_seq")
    @SequenceGenerator(name = "model_seq", sequenceName = "SEQ_MODELE", allocationSize = 1)
    @Column(name = "id_modelu")
    private Long idModelu;

    @Column(name = "id_producenta")
    private Long idProducenta;

    @NotBlank(message = "Nazwa modelu jest wymagana")
    @Column(name = "nazwa_modelu", length = 50, nullable = false)
    private String nazwaModelu;

    @Column(name = "typ_nadwozia", length = 15)
    private String typNadwozia;

    @Column(name = "pojemnosc_silnika")
    private Double pojemnoscSilnika;

    @Column(name = "moc_km")
    private Integer mocKm;

    @Column(name = "rodzaj_paliwa", length = 15)
    private String rodzajPaliwa;

    @Column(name = "liczba_miejsc")
    private Integer liczbaMiejsc;

    public String getFullName() {
        return nazwaModelu + " (" + rodzajPaliwa + ", " + mocKm + " KM)";
    }
}
