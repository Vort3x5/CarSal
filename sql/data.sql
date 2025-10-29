-- ==============================================
-- Skrypt naprawy bazy danych
-- 1. Dodanie kolumny haslo do tabeli Klienci
-- 2. Wstawienie danych testowych (producenci i modele)
-- ==============================================

SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON

PROMPT ========================================
PROMPT Naprawa bazy danych - Salon Samochodowy
PROMPT ========================================

-- ==============================================
-- KROK 1: Dodanie brakującej kolumny haslo
-- ==============================================

PROMPT
PROMPT === Dodawanie kolumny haslo do tabeli Klienci ===

ALTER TABLE Klienci ADD haslo VARCHAR2(100);

PROMPT Kolumna haslo została dodana pomyślnie
PROMPT

-- ==============================================
-- KROK 2: Wstawienie producentów
-- ==============================================

PROMPT === Wstawienie producentów ===

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('Toyota', 'Japonia');

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('Volkswagen', 'Niemcy');

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('BMW', 'Niemcy');

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('Ford', 'USA');

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('Audi', 'Niemcy');

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('Mercedes-Benz', 'Niemcy');

INSERT INTO Producenci (nazwa_producenta, kraj_pochodzenia) 
VALUES ('Tesla', 'USA');

COMMIT;

PROMPT Dodano 7 producentów
PROMPT

-- ==============================================
-- KROK 3: Wstawienie modeli samochodów
-- ==============================================

PROMPT === Wstawienie modeli samochodów ===

-- Toyota
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Corolla', 'Sedan', 1.8, 140, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Toyota';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'RAV4', 'SUV', 2.5, 218, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Toyota';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Yaris', 'Hatchback', 1.5, 120, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Toyota';

-- Volkswagen
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Golf', 'Hatchback', 1.5, 150, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Volkswagen';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Passat', 'Sedan', 2.0, 190, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Volkswagen';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Tiguan', 'SUV', 2.0, 220, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Volkswagen';

-- BMW
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Seria 3', 'Sedan', 2.0, 184, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'BMW';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Seria 5', 'Sedan', 3.0, 340, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'BMW';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'X5', 'SUV', 3.0, 340, 'Diesel', 7 
FROM Producenci WHERE nazwa_producenta = 'BMW';

-- Ford
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Focus', 'Hatchback', 1.5, 125, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Ford';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Mustang', 'Sedan', 5.0, 460, 'Benzyna', 4 
FROM Producenci WHERE nazwa_producenta = 'Ford';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Kuga', 'SUV', 2.5, 225, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Ford';

-- Audi
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'A4', 'Sedan', 2.0, 190, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Audi';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'A6', 'Sedan', 3.0, 340, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Audi';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Q5', 'SUV', 2.0, 249, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Audi';

-- Mercedes-Benz
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'C-Class', 'Sedan', 2.0, 204, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Mercedes-Benz';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'E-Class', 'Sedan', 3.0, 367, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Mercedes-Benz';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'GLE', 'SUV', 3.0, 367, 'Diesel', 7 
FROM Producenci WHERE nazwa_producenta = 'Mercedes-Benz';

-- Tesla
INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Model 3', 'Sedan', NULL, 450, 'Elektryczny', 5 
FROM Producenci WHERE nazwa_producenta = 'Tesla';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Model Y', 'SUV', NULL, 534, 'Elektryczny', 7 
FROM Producenci WHERE nazwa_producenta = 'Tesla';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Model S', 'Sedan', NULL, 670, 'Elektryczny', 5 
FROM Producenci WHERE nazwa_producenta = 'Tesla';

COMMIT;

PROMPT Dodano 21 modeli samochodów
PROMPT

-- ==============================================
-- WERYFIKACJA
-- ==============================================

PROMPT
PROMPT === Weryfikacja danych ===
PROMPT

SELECT 'Producenci: ' || COUNT(*) AS info FROM Producenci;
SELECT 'Modele: ' || COUNT(*) AS info FROM Modele_Samochodow;
SELECT 'Struktura tabeli Klienci:' AS info FROM dual;
DESC Klienci;

PROMPT
PROMPT === Przykładowe modele ===
SELECT 
    p.nazwa_producenta,
    m.nazwa_modelu,
    m.typ_nadwozia,
    m.rodzaj_paliwa,
    m.moc_km
FROM Modele_Samochodow m
JOIN Producenci p ON m.id_producenta = p.id_producenta
ORDER BY p.nazwa_producenta, m.nazwa_modelu
FETCH FIRST 10 ROWS ONLY;

PROMPT
PROMPT ========================================
PROMPT Naprawa zakończona pomyślnie!
PROMPT ========================================
PROMPT
PROMPT Następne kroki:
PROMPT 1. Uruchom ponownie aplikację Spring Boot
PROMPT 2. Formularz dodawania pojazdu powinien teraz pokazywać modele
PROMPT 3. Dashboard powinien działać poprawnie
PROMPT ========================================
