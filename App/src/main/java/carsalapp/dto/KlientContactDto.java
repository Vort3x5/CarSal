package carsalapp.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public class KlientContactDto {

    @NotBlank(message = "Telefon jest wymagany")
    @Pattern(regexp = "[0-9\\- ]{7,15}", message = "Telefon musi mieć 7-15 cyfr i może zawierać myślniki lub spacje")
    private String telefon;

    @NotBlank(message = "Email jest wymagany")
    @Email(message = "Nieprawidłowy format email")
    private String email;

    public KlientContactDto() {
    }

    public KlientContactDto(String telefon, String email) {
        this.telefon = telefon;
        this.email = email;
    }

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
