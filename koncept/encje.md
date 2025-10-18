# Model Konceptualny - Encje (liczba pojedyncza!)

## 1. SALON (główna encja - lewy górny róg)
- nr_salonu (PK, id_xxx lub nr_xxx)
- nazwa
- adres (COMPOSITE: ulica, miasto, kod_pocztowy)
- telefon
- email

## 2. POJAZD
- nr_vin (PK)
- rok_produkcji
- przebieg
- kolor
- cena_katalogowa
- stan {Nowy, Uzywany}
- status {Dostepny, Sprzedany, Rezerwacja, Serwis}
- data_przyjecia
- uwagi (MULTIVALUED or TEXT - use varchar(500))

## 3. MODEL_SAMOCHODU
- id_modelu (PK)
- nazwa_modelu
- typ_nadwozia {Sedan, SUV, Hatchback, Kombi}
- pojemnosc_silnika
- moc_km
- rodzaj_paliwa {Benzyna, Diesel, Elektryczny, Hybryda}
- liczba_miejsc

## 4. PRODUCENT
- id_producenta (PK)
- nazwa_producenta
- kraj_pochodzenia

## 5. KLIENT
- nr_klienta (PK)
- typ_klienta {Indywidualny, Firma}
- dane_osobowe (COMPOSITE: imie, nazwisko, pesel)
- dane_firmowe (COMPOSITE: nazwa_firmy, nip)
- adres (COMPOSITE)
- telefon
- email
- data_rejestracji

## 6. PRACOWNIK (z dziedziczeniem/specjalizacją!)
- nr_pracownika (PK)
- imie
- nazwisko
- pesel
- stanowisko
- data_zatrudnienia
- pensja_podstawowa

### SPRZEDAWCA (specjalizacja PRACOWNIKA - 2-3 atrybuty!)
- prowizja_procent
- limit_rabatu_procent
- liczba_sprzedazy

### SERWISANT (specjalizacja PRACOWNIKA)
- specjalizacja
- certyfikaty (TEXT/MULTIVALUED)
- stawka_godzinowa

## 7. SPRZEDAZ
- nr_sprzedazy (PK)
- data_sprzedazy
- cena_sprzedazy
- cena_koncowa
- metoda_platnosci {Gotowka, Przelew, Finansowanie, Leasing}
- status {W_trakcie, Zakonczona, Anulowana}

## 8. WYPOSAZENIE (dla M:N relationship!)
- id_wyposazenia (PK)
- nazwa
- kategoria {Bezpieczenstwo, Komfort, Multimedia}
- dodatkowa_cena
