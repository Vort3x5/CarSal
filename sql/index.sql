-- ==============================================
-- Indeksy - Strojenie bazy danych
-- Sekcja 5.2 dokumentacji
-- ==============================================

SET ECHO ON
SET FEEDBACK ON

PROMPT ========================================
PROMPT Tworzenie indeksów dla optymalizacji
PROMPT ========================================
PROMPT

-- ==============================================
-- INDEKSY NA KLUCZACH OBCYCH (FK)
-- Bardzo ważne dla JOIN'ów i CASCADE DELETE
-- ==============================================

-- Modele_Samochodow
CREATE INDEX idx_modele_producent ON Modele_Samochodow(id_producenta);

-- Pojazdy
CREATE INDEX idx_pojazdy_model ON Pojazdy(id_modelu);
CREATE INDEX idx_pojazdy_salon ON Pojazdy(nr_salonu);

-- Pracownicy
CREATE INDEX idx_pracownicy_salon ON Pracownicy(nr_salonu);

-- Sprzedaze
CREATE INDEX idx_sprzedaze_klient ON Sprzedaze(nr_klienta);
CREATE INDEX idx_sprzedaze_pracownik ON Sprzedaze(nr_pracownika);
-- nr_vin już ma UNIQUE, więc automatycznie ma indeks

-- Certyfikaty_Serwisanta
CREATE INDEX idx_certyfikaty_pracownik ON Certyfikaty_Serwisanta(nr_pracownika);

-- Pojazdy_Wyposazenie
-- Już ma indeks na PK (nr_vin, id_wyposazenia)
CREATE INDEX idx_pw_wyposazenie ON Pojazdy_Wyposazenie(id_wyposazenia);

-- Jazdy_Testowe
CREATE INDEX idx_jazdy_klient ON Jazdy_Testowe(nr_klienta);
CREATE INDEX idx_jazdy_pojazd ON Jazdy_Testowe(nr_vin);

PROMPT === Indeksy na kluczach obcych utworzone ===
PROMPT

-- ==============================================
-- INDEKSY NA KOLUMNACH CZĘSTO UŻYWANYCH W WHERE
-- ==============================================

-- Pojazdy - często wyszukiwane po statusie
CREATE INDEX idx_pojazdy_status ON Pojazdy(status);

-- Pojazdy - często wyszukiwane po stanie (Nowy/Uzywany)
CREATE INDEX idx_pojazdy_stan ON Pojazdy(stan);

-- Pojazdy - często wyszukiwane po roku produkcji
CREATE INDEX idx_pojazdy_rok ON Pojazdy(rok_produkcji);

-- Klienci - wyszukiwanie po typie (Indywidualny/Firma)
CREATE INDEX idx_klienci_typ ON Klienci(typ_klienta);

-- Sprzedaze - wyszukiwanie po dacie (raporty)
CREATE INDEX idx_sprzedaze_data ON Sprzedaze(data_sprzedazy);

-- Sprzedaze - wyszukiwanie po statusie
CREATE INDEX idx_sprzedaze_status ON Sprzedaze(status);

-- Jazdy_Testowe - wyszukiwanie po dacie
CREATE INDEX idx_jazdy_data ON Jazdy_Testowe(data_jazdy);

-- Jazdy_Testowe - wyszukiwanie po statusie
CREATE INDEX idx_jazdy_status ON Jazdy_Testowe(status);

PROMPT === Indeksy na kolumnach WHERE utworzone ===
PROMPT

-- ==============================================
-- INDEKSY ZŁOŻONE (COMPOSITE)
-- Dla często wykonywanych zapytań z wieloma warunkami
-- ==============================================

-- Wyszukiwanie dostępnych pojazdów nowych
CREATE INDEX idx_pojazdy_status_stan ON Pojazdy(status, stan);

-- Wyszukiwanie pojazdów w salonie po statusie
CREATE INDEX idx_pojazdy_salon_status ON Pojazdy(nr_salonu, status);

-- Sprzedaże w okresie dla klienta
CREATE INDEX idx_sprzedaze_klient_data ON Sprzedaze(nr_klienta, data_sprzedazy);

-- Jazdy testowe dla pojazdu w okresie
CREATE INDEX idx_jazdy_pojazd_data ON Jazdy_Testowe(nr_vin, data_jazdy);

PROMPT === Indeksy złożone utworzone ===
PROMPT

-- ==============================================
-- INDEKSY FUNKCYJNE
-- Dla wyszukiwania bez uwzględniania wielkości liter
-- ==============================================

-- Wyszukiwanie klientów po nazwisku (case-insensitive)
CREATE INDEX idx_klienci_nazwisko_upper ON Klienci(UPPER(nazwisko));

-- Wyszukiwanie salonów po nazwie (case-insensitive)
CREATE INDEX idx_salony_nazwa_upper ON Salony(UPPER(nazwa));

PROMPT === Indeksy funkcyjne utworzone ===
PROMPT

-- ==============================================
-- WERYFIKACJA INDEKSÓW
-- ==============================================

PROMPT
PROMPT === Podsumowanie utworzonych indeksów ===
SELECT 
    index_name, 
    table_name, 
    uniqueness,
    status
FROM user_indexes 
WHERE table_name IN (
    'SALONY', 'PRODUCENCI', 'MODELE_SAMOCHODOW', 'POJAZDY', 
    'KLIENCI', 'PRACOWNICY', 'SPRZEDAWCY', 'SERWISANCI',
    'CERTYFIKATY_SERWISANTA', 'SPRZEDAZE', 'WYPOSAZENIE',
    'POJAZDY_WYPOSAZENIE', 'JAZDY_TESTOWE'
)
ORDER BY table_name, index_name;

PROMPT
PROMPT === Szczegóły kolumn indeksów ===
SELECT 
    ic.index_name,
    ic.table_name,
    ic.column_name,
    ic.column_position
FROM user_ind_columns ic
WHERE ic.table_name IN (
    'SALONY', 'PRODUCENCI', 'MODELE_SAMOCHODOW', 'POJAZDY', 
    'KLIENCI', 'PRACOWNICY', 'SPRZEDAWCY', 'SERWISANCI',
    'CERTYFIKATY_SERWISANTA', 'SPRZEDAZE', 'WYPOSAZENIE',
    'POJAZDY_WYPOSAZENIE', 'JAZDY_TESTOWE'
)
ORDER BY ic.table_name, ic.index_name, ic.column_position;

PROMPT
PROMPT ========================================
PROMPT Indeksy utworzone pomyślnie!
PROMPT ========================================
