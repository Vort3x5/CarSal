# Związki - Model Konceptualny

**MUSI być przynajmniej jeden związek M:N!**

## Związki 1:M

1. SALON ←[posiada]→ POJAZD (1:M)
   - Krotność: (1,1) : (0,N)
   - Salon ma wiele pojazdów, pojazd należy do jednego salonu

2. SALON ←[zatrudnia]→ PRACOWNIK (1:M)
   - Krotność: (1,1) : (0,N)

3. MODEL_SAMOCHODU ←[jest_instancja]→ POJAZD (1:M)
   - Krotność: (1,1) : (1,N)

4. PRODUCENT ←[produkuje]→ MODEL_SAMOCHODU (1:M)
   - Krotność: (1,1) : (1,N)

5. KLIENT ←[dokonuje]→ SPRZEDAZ (1:M)
   - Krotność: (1,1) : (0,N)

6. PRACOWNIK ←[realizuje]→ SPRZEDAZ (1:M)
   - Krotność: (1,1) : (0,N)

7. POJAZD ←[jest_przedmiotem]→ SPRZEDAZ (M:1)
   - Krotność: (1,1) : (0,1)
   - Pojazd może być sprzedany tylko raz

1. POJAZD ←[ma_wyposazenie]→ WYPOSAZENIE (M:N)
   - Krotność: (1,N) : (0,N)
   - Pojazd może mieć wiele wyposażeń
   - Wyposażenie może być w wielu pojazdach

2. KLIENT ←[rezerwuje]→ TEST_DRIVE ←[używa]→ POJAZD (M:N przez TEST_DRIVE)
   - Klient może mieć wiele jazd testowych
   - Pojazd może być użyty w wielu jazdach testowych
