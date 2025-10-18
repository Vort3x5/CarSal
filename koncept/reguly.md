# Reguły biznesowe i integralności

## Reguły domenowe

1. PESEL musi mieć dokładnie 11 znaków: `CHAR(11)`
2. Cena pojazdu musi być > 0
3. Rok produkcji: 1900 <= rok <= 2025
4. Przebieg >= 0
5. Stan pojazdu: `IN ('Nowy', 'Uzywany')`
6. Metoda płatności: `IN ('Gotowka', 'Przelew', 'Finansowanie', 'Leasing')`
7. Email musi być unikalny
8. NIP (dla firm): 10 cyfr

## Reguły encji

1. Każdy POJAZD musi mieć przypisany MODEL_SAMOCHODU
2. SPRZEDAZ wymaga KLIENTA i POJAZDU
3. Cena końcowa <= cena sprzedaży (rabat)
4. Data zatrudnienia <= data zwolnienia (jeśli istnieje)
5. KLIENT typu "Indywidualny" musi mieć PESEL
6. KLIENT typu "Firma" musi mieć NIP

## Reguły referencyjne

1. POJAZD ze statusem "Sprzedany" musi mieć powiązaną SPRZEDAZ
2. Nie można usunąć KLIENTA, który ma historię SPRZEDAZY
3. Nie można usunąć POJAZDU, który został sprzedany
4. TEST_DRIVE wymaga ważnego numeru prawa jazdy

## Klucze kandydujące

### SALON
- PK: nr_salonu
- UK: nazwa

### POJAZD
- PK: nr_vin (unique by definition)

### KLIENT
- PK: nr_klienta
- UK: pesel (dla indywidualnych)
- UK: nip (dla firm)

### PRACOWNIK
- PK: nr_pracownika
- UK: pesel
- UK: email
