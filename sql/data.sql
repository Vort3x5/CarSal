SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON

INSERT INTO Salony (nazwa, ulica, miasto, kod_pocztowy, telefon, email)
VALUES ('Auto Plaza Warszawa', 'Puławska 478', 'Warszawa', '02-884', '22-123-4567', 'kontakt@autoplaza.pl');

INSERT INTO Salony (nazwa, ulica, miasto, kod_pocztowy, telefon, email)
VALUES ('Premium Motors Kraków', 'Czerwone Maki 82', 'Kraków', '30-392', '12-345-6789', 'biuro@premiummotors.pl');

INSERT INTO Salony (nazwa, ulica, miasto, kod_pocztowy, telefon, email)
VALUES ('City Cars Gdańsk', 'Grunwaldzka 411', 'Gdańsk', '80-309', '58-987-6543', 'info@citycars.pl');

COMMIT;

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

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Corolla', 'Sedan', 1.8, 140, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Toyota';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'RAV4', 'SUV', 2.5, 218, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Toyota';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Yaris', 'Hatchback', 1.5, 120, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Toyota';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Golf', 'Hatchback', 1.5, 150, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Volkswagen';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Passat', 'Sedan', 2.0, 190, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Volkswagen';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Tiguan', 'SUV', 2.0, 220, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Volkswagen';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Seria 3', 'Sedan', 2.0, 184, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'BMW';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Seria 5', 'Sedan', 3.0, 340, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'BMW';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'X5', 'SUV', 3.0, 340, 'Diesel', 7 
FROM Producenci WHERE nazwa_producenta = 'BMW';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Focus', 'Hatchback', 1.5, 125, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Ford';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Mustang', 'Sedan', 5.0, 460, 'Benzyna', 4 
FROM Producenci WHERE nazwa_producenta = 'Ford';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Kuga', 'SUV', 2.5, 225, 'Hybryda', 5 
FROM Producenci WHERE nazwa_producenta = 'Ford';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'A4', 'Sedan', 2.0, 190, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Audi';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'A6', 'Sedan', 3.0, 340, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Audi';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'Q5', 'SUV', 2.0, 249, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Audi';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'C-Class', 'Sedan', 2.0, 204, 'Benzyna', 5 
FROM Producenci WHERE nazwa_producenta = 'Mercedes-Benz';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'E-Class', 'Sedan', 3.0, 367, 'Diesel', 5 
FROM Producenci WHERE nazwa_producenta = 'Mercedes-Benz';

INSERT INTO Modele_Samochodow (id_producenta, nazwa_modelu, typ_nadwozia, pojemnosc_silnika, moc_km, rodzaj_paliwa, liczba_miejsc) 
SELECT id_producenta, 'GLE', 'SUV', 3.0, 367, 'Diesel', 7 
FROM Producenci WHERE nazwa_producenta = 'Mercedes-Benz';

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

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT 'JT2BF18K3X0123456', m.id_modelu, s.nr_salonu, 2023, 0, 'Czerwony', 125000.00, 'Nowy', 'Dostepny', 'Model demonstracyjny'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'Corolla' AND s.nazwa = 'Auto Plaza Warszawa';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT '2T1BURHE5KC234567', m.id_modelu, s.nr_salonu, 2023, 0, 'Biały', 165000.00, 'Nowy', 'Dostepny', NULL
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'RAV4' AND s.nazwa = 'Auto Plaza Warszawa';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT 'WVWZZZ1KZ8W345678', m.id_modelu, s.nr_salonu, 2022, 25000, 'Srebrny', 95000.00, 'Uzywany', 'Dostepny', 'Po pierwszym właścicielu'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'Golf' AND s.nazwa = 'Premium Motors Kraków';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT 'WBA3C1C50DF456789', m.id_modelu, s.nr_salonu, 2024, 0, 'Czarny', 285000.00, 'Nowy', 'Dostepny', NULL
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'Seria 5' AND s.nazwa = 'Premium Motors Kraków';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT '5UXKR0C52E0567890', m.id_modelu, s.nr_salonu, 2024, 0, 'Granatowy', 420000.00, 'Nowy', 'Dostepny', 'Pakiet M Sport'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'X5' AND s.nazwa = 'Premium Motors Kraków';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT 'WAUZZZ4G6DN678901', m.id_modelu, s.nr_salonu, 2023, 15000, 'Szary', 195000.00, 'Uzywany', 'Dostepny', 'Serwisowany w ASO'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'A4' AND s.nazwa = 'City Cars Gdańsk';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT 'WDD2130091A789012', m.id_modelu, s.nr_salonu, 2024, 0, 'Biały', 315000.00, 'Nowy', 'Dostepny', 'Pakiet AMG Line'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'E-Class' AND s.nazwa = 'City Cars Gdańsk';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT '5YJ3E1EA1KF890123', m.id_modelu, s.nr_salonu, 2024, 0, 'Czerwony', 225000.00, 'Nowy', 'Dostepny', 'Autopilot Enhanced'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'Model 3' AND s.nazwa = 'City Cars Gdańsk';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT '7FARW5H87LE901234', m.id_modelu, s.nr_salonu, 2024, 0, 'Niebieski', 575000.00, 'Nowy', 'Dostepny', 'GT Performance Package'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'Mustang' AND s.nazwa = 'Auto Plaza Warszawa';

INSERT INTO Pojazdy (nr_vin, id_modelu, nr_salonu, rok_produkcji, przebieg, kolor, cena_katalogowa, stan, status, uwagi)
SELECT 'JTMDFREVXLD012345', m.id_modelu, s.nr_salonu, 2023, 8500, 'Zielony', 90000.00, 'Uzywany', 'Dostepny', 'Idealny stan'
FROM Modele_Samochodow m, Salony s
WHERE m.nazwa_modelu = 'Yaris' AND s.nazwa = 'Auto Plaza Warszawa';

COMMIT;

INSERT INTO Klienci (typ_klienta, imie, nazwisko, pesel, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Indywidualny', 'Jan', 'Kowalski', '85010112345', '501-234-567', 'jan.kowalski@email.pl', 'Marszałkowska 15', 'Warszawa', '00-626');

INSERT INTO Klienci (typ_klienta, imie, nazwisko, pesel, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Indywidualny', 'Anna', 'Nowak', '90020223456', '602-345-678', 'anna.nowak@email.pl', 'Długa 42', 'Kraków', '31-147');

INSERT INTO Klienci (typ_klienta, imie, nazwisko, pesel, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Indywidualny', 'Piotr', 'Wiśniewski', '88030334567', '503-456-789', 'piotr.wisniewski@email.pl', 'Wiejska 8', 'Gdańsk', '80-123');

INSERT INTO Klienci (typ_klienta, imie, nazwisko, pesel, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Indywidualny', 'Maria', 'Lewandowska', '92040445678', '604-567-890', 'maria.lewandowska@email.pl', 'Polna 23', 'Poznań', '60-624');

INSERT INTO Klienci (typ_klienta, nazwa_firmy, nip, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Firma', 'Tech Solutions Sp. z o.o.', '1234567890', '22-567-8901', 'kontakt@techsolutions.pl', 'Prosta 51', 'Warszawa', '00-838');

INSERT INTO Klienci (typ_klienta, nazwa_firmy, nip, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Firma', 'Auto Trans SA', '9876543210', '12-678-9012', 'biuro@autotrans.pl', 'Krakowska 88', 'Kraków', '30-553');

INSERT INTO Klienci (typ_klienta, imie, nazwisko, pesel, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Indywidualny', 'Tomasz', 'Zieliński', '87050556789', '505-678-901', 'tomasz.zielinski@email.pl', 'Słoneczna 12', 'Wrocław', '50-420');

INSERT INTO Klienci (typ_klienta, imie, nazwisko, pesel, telefon, email, ulica, miasto, kod_pocztowy)
VALUES ('Indywidualny', 'Katarzyna', 'Dąbrowska', '93060667890', '606-789-012', 'katarzyna.dabrowska@email.pl', 'Lipowa 7', 'Łódź', '90-562');

COMMIT;

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Marek', 'Nowacki', '82071178901', 'Sprzedawca', DATE '2020-03-15', 5500.00
FROM Salony s WHERE s.nazwa = 'Auto Plaza Warszawa';

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Agnieszka', 'Kowalczyk', '89082289012', 'Sprzedawca', DATE '2021-06-01', 5200.00
FROM Salony s WHERE s.nazwa = 'Auto Plaza Warszawa';

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Krzysztof', 'Mazur', '85093390123', 'Sprzedawca', DATE '2019-09-10', 6000.00
FROM Salony s WHERE s.nazwa = 'Premium Motors Kraków';

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Beata', 'Wójcik', '91104401234', 'Sprzedawca', DATE '2022-01-20', 5000.00
FROM Salony s WHERE s.nazwa = 'City Cars Gdańsk';

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Robert', 'Kamiński', '88011512345', 'Serwisant', DATE '2018-05-12', 5800.00
FROM Salony s WHERE s.nazwa = 'Auto Plaza Warszawa';

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Monika', 'Piotrowska', '90122623456', 'Serwisant', DATE '2020-11-05', 5500.00
FROM Salony s WHERE s.nazwa = 'Premium Motors Kraków';

INSERT INTO Pracownicy (nr_salonu, imie, nazwisko, pesel, stanowisko, data_zatrudnienia, pensja_podstawowa)
SELECT s.nr_salonu, 'Andrzej', 'Grabowski', '86033734567', 'Serwisant', DATE '2019-02-28', 6200.00
FROM Salony s WHERE s.nazwa = 'City Cars Gdańsk';

COMMIT;

INSERT INTO Sprzedawcy (nr_pracownika, prowizja_procent, limit_rabatu_procent)
SELECT p.nr_pracownika, 3.5, 10.0
FROM Pracownicy p WHERE p.nazwisko = 'Nowacki';

INSERT INTO Sprzedawcy (nr_pracownika, prowizja_procent, limit_rabatu_procent)
SELECT p.nr_pracownika, 3.0, 8.0
FROM Pracownicy p WHERE p.nazwisko = 'Kowalczyk';

INSERT INTO Sprzedawcy (nr_pracownika, prowizja_procent, limit_rabatu_procent)
SELECT p.nr_pracownika, 4.0, 12.0
FROM Pracownicy p WHERE p.nazwisko = 'Mazur';

INSERT INTO Sprzedawcy (nr_pracownika, prowizja_procent, limit_rabatu_procent)
SELECT p.nr_pracownika, 2.5, 7.0
FROM Pracownicy p WHERE p.nazwisko = 'Wójcik';

COMMIT;

INSERT INTO Serwisanci (nr_pracownika, specjalizacja, stawka_godzinowa)
SELECT p.nr_pracownika, 'Mechanika silników', 85.00
FROM Pracownicy p WHERE p.nazwisko = 'Kamiński';

INSERT INTO Serwisanci (nr_pracownika, specjalizacja, stawka_godzinowa)
SELECT p.nr_pracownika, 'Elektronika i diagnostyka', 90.00
FROM Pracownicy p WHERE p.nazwisko = 'Piotrowska';

INSERT INTO Serwisanci (nr_pracownika, specjalizacja, stawka_godzinowa)
SELECT p.nr_pracownika, 'Mechanika ogólna', 80.00
FROM Pracownicy p WHERE p.nazwisko = 'Grabowski';

COMMIT;

INSERT INTO Certyfikaty_Serwisanta (nr_pracownika, certyfikat, data_uzyskania)
SELECT p.nr_pracownika, 'Toyota Hybrid Specialist', DATE '2021-05-15'
FROM Pracownicy p WHERE p.nazwisko = 'Kamiński';

INSERT INTO Certyfikaty_Serwisanta (nr_pracownika, certyfikat, data_uzyskania)
SELECT p.nr_pracownika, 'BMW Master Technician', DATE '2022-03-20'
FROM Pracownicy p WHERE p.nazwisko = 'Kamiński';

INSERT INTO Certyfikaty_Serwisanta (nr_pracownika, certyfikat, data_uzyskania)
SELECT p.nr_pracownika, 'Advanced Diagnostics Level 3', DATE '2023-01-10'
FROM Pracownicy p WHERE p.nazwisko = 'Piotrowska';

INSERT INTO Certyfikaty_Serwisanta (nr_pracownika, certyfikat, data_uzyskania)
SELECT p.nr_pracownika, 'Tesla Electric Vehicle Certified', DATE '2023-06-05'
FROM Pracownicy p WHERE p.nazwisko = 'Piotrowska';

INSERT INTO Certyfikaty_Serwisanta (nr_pracownika, certyfikat, data_uzyskania)
SELECT p.nr_pracownika, 'Audi Service Excellence', DATE '2020-09-12'
FROM Pracownicy p WHERE p.nazwisko = 'Grabowski';

COMMIT;

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Adaptacyjny tempomat', 'Bezpieczenstwo', 3500.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('System kamer 360', 'Bezpieczenstwo', 2800.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Czujniki parkowania', 'Bezpieczenstwo', 1200.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Asystent martwego pola', 'Bezpieczenstwo', 1800.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Skórzana tapicerka', 'Komfort', 5500.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Fotele wentylowane', 'Komfort', 3200.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Panoramiczny dach', 'Komfort', 4500.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Klimatyzacja 3-strefowa', 'Komfort', 2500.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('System nawigacji Premium', 'Multimedia', 3800.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('System audio Hi-Fi', 'Multimedia', 4200.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Wyświetlacz Head-Up', 'Multimedia', 2900.00);

INSERT INTO Wyposazenie (nazwa, kategoria, dodatkowa_cena)
VALUES ('Bezprzewodowa ładowarka', 'Multimedia', 800.00);

COMMIT;

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = 'JT2BF18K3X0123456' AND w.nazwa = 'Adaptacyjny tempomat';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = 'JT2BF18K3X0123456' AND w.nazwa = 'System kamer 360';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '2T1BURHE5KC234567' AND w.nazwa = 'Panoramiczny dach';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '2T1BURHE5KC234567' AND w.nazwa = 'System nawigacji Premium';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = 'WBA3C1C50DF456789' AND w.nazwa = 'Skórzana tapicerka';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = 'WBA3C1C50DF456789' AND w.nazwa = 'Fotele wentylowane';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = 'WBA3C1C50DF456789' AND w.nazwa = 'System audio Hi-Fi';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '5UXKR0C52E0567890' AND w.nazwa = 'Adaptacyjny tempomat';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '5UXKR0C52E0567890' AND w.nazwa = 'System kamer 360';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '5UXKR0C52E0567890' AND w.nazwa = 'Panoramiczny dach';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '5YJ3E1EA1KF890123' AND w.nazwa = 'System nawigacji Premium';

INSERT INTO Pojazdy_Wyposazenie (nr_vin, id_wyposazenia)
SELECT p.nr_vin, w.id_wyposazenia
FROM Pojazdy p, Wyposazenie w
WHERE p.nr_vin = '5YJ3E1EA1KF890123' AND w.nazwa = 'Wyświetlacz Head-Up';

COMMIT;

INSERT INTO Sprzedaze (nr_vin, nr_klienta, nr_pracownika, data_sprzedazy, cena_sprzedazy, cena_koncowa, metoda_platnosci, status)
SELECT 
    p.nr_vin,
    k.nr_klienta,
    sp.nr_pracownika,
    DATE '2024-09-15',
    125000.00,
    120000.00,
    'Finansowanie',
    'Zakonczona'
FROM Pojazdy p, Klienci k, Sprzedawcy sp, Pracownicy pr
WHERE p.nr_vin = 'JT2BF18K3X0123456' 
  AND k.nazwisko = 'Kowalski'
  AND pr.nazwisko = 'Nowacki'
  AND sp.nr_pracownika = pr.nr_pracownika;

UPDATE Pojazdy SET status = 'Sprzedany' WHERE nr_vin = 'JT2BF18K3X0123456';

INSERT INTO Sprzedaze (nr_vin, nr_klienta, nr_pracownika, data_sprzedazy, cena_sprzedazy, cena_koncowa, metoda_platnosci, status)
SELECT 
    p.nr_vin,
    k.nr_klienta,
    sp.nr_pracownika,
    DATE '2024-10-05',
    95000.00,
    88000.00,
    'Gotowka',
    'Zakonczona'
FROM Pojazdy p, Klienci k, Sprzedawcy sp, Pracownicy pr
WHERE p.nr_vin = 'WVWZZZ1KZ8W345678' 
  AND k.nazwisko = 'Nowak'
  AND pr.nazwisko = 'Mazur'
  AND sp.nr_pracownika = pr.nr_pracownika;

UPDATE Pojazdy SET status = 'Sprzedany' WHERE nr_vin = 'WVWZZZ1KZ8W345678';

INSERT INTO Sprzedaze (nr_vin, nr_klienta, nr_pracownika, data_sprzedazy, cena_sprzedazy, cena_koncowa, metoda_platnosci, status)
SELECT 
    p.nr_vin,
    k.nr_klienta,
    sp.nr_pracownika,
    DATE '2024-10-20',
    285000.00,
    275000.00,
    'Przelew',
    'Zakonczona'
FROM Pojazdy p, Klienci k, Sprzedawcy sp, Pracownicy pr
WHERE p.nr_vin = 'WBA3C1C50DF456789' 
  AND k.nazwa_firmy = 'Tech Solutions Sp. z o.o.'
  AND pr.nazwisko = 'Mazur'
  AND sp.nr_pracownika = pr.nr_pracownika;

UPDATE Pojazdy SET status = 'Sprzedany' WHERE nr_vin = 'WBA3C1C50DF456789';

COMMIT;

INSERT INTO Jazdy_Testowe (nr_klienta, nr_vin, data_jazdy, godzina_jazdy, nr_prawa_jazdy, status)
SELECT 
    k.nr_klienta,
    p.nr_vin,
    DATE '2024-10-28',
    TO_TIMESTAMP('2024-10-28 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ABC123456',
    'Odbyta'
FROM Klienci k, Pojazdy p
WHERE k.nazwisko = 'Wiśniewski' AND p.nr_vin = '2T1BURHE5KC234567';

INSERT INTO Jazdy_Testowe (nr_klienta, nr_vin, data_jazdy, godzina_jazdy, nr_prawa_jazdy, status)
SELECT 
    k.nr_klienta,
    p.nr_vin,
    DATE '2024-11-01',
    TO_TIMESTAMP('2024-11-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    'DEF789012',
    'Odbyta'
FROM Klienci k, Pojazdy p
WHERE k.nazwisko = 'Lewandowska' AND p.nr_vin = '5UXKR0C52E0567890';

INSERT INTO Jazdy_Testowe (nr_klienta, nr_vin, data_jazdy, godzina_jazdy, nr_prawa_jazdy, status)
SELECT 
    k.nr_klienta,
    p.nr_vin,
    DATE '2024-11-05',
    TO_TIMESTAMP('2024-11-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    'GHI345678',
    'Odbyta'
FROM Klienci k, Pojazdy p
WHERE k.nazwisko = 'Zieliński' AND p.nr_vin = '5YJ3E1EA1KF890123';

INSERT INTO Jazdy_Testowe (nr_klienta, nr_vin, data_jazdy, godzina_jazdy, nr_prawa_jazdy, status)
SELECT 
    k.nr_klienta,
    p.nr_vin,
    DATE '2024-11-08',
    TO_TIMESTAMP('2024-11-08 15:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'JKL901234',
    'Zarezerwowana'
FROM Klienci k, Pojazdy p
WHERE k.nazwisko = 'Dąbrowska' AND p.nr_vin = '7FARW5H87LE901234';

UPDATE Pojazdy SET status = 'Rezerwacja' WHERE nr_vin = '7FARW5H87LE901234';

INSERT INTO Jazdy_Testowe (nr_klienta, nr_vin, data_jazdy, godzina_jazdy, nr_prawa_jazdy, status)
SELECT 
    k.nr_klienta,
    p.nr_vin,
    DATE '2024-11-10',
    TO_TIMESTAMP('2024-11-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    'MNO567890',
    'Zarezerwowana'
FROM Klienci k, Pojazdy p
WHERE k.nazwisko = 'Wiśniewski' AND p.nr_vin = 'WAUZZZ4G6DN678901';

UPDATE Pojazdy SET status = 'Rezerwacja' WHERE nr_vin = 'WAUZZZ4G6DN678901';

COMMIT;

SELECT 'Salony: ' || COUNT(*) AS liczba FROM Salony;
SELECT 'Producenci: ' || COUNT(*) AS liczba FROM Producenci;
SELECT 'Modele: ' || COUNT(*) AS liczba FROM Modele_Samochodow;
SELECT 'Pojazdy: ' || COUNT(*) AS liczba FROM Pojazdy;
SELECT 'Klienci: ' || COUNT(*) AS liczba FROM Klienci;
SELECT 'Pracownicy: ' || COUNT(*) AS liczba FROM Pracownicy;
SELECT 'Sprzedawcy: ' || COUNT(*) AS liczba FROM Sprzedawcy;
SELECT 'Serwisanci: ' || COUNT(*) AS liczba FROM Serwisanci;
SELECT 'Certyfikaty: ' || COUNT(*) AS liczba FROM Certyfikaty_Serwisanta;
SELECT 'Sprzedaze: ' || COUNT(*) AS liczba FROM Sprzedaze;
SELECT 'Wyposazenie: ' || COUNT(*) AS liczba FROM Wyposazenie;
SELECT 'Pojazdy_Wyposazenie: ' || COUNT(*) AS liczba FROM Pojazdy_Wyposazenie;
SELECT 'Jazdy_Testowe: ' || COUNT(*) AS liczba FROM Jazdy_Testowe;

SELECT 
    pr.nazwa_producenta,
    m.nazwa_modelu,
    p.kolor,
    p.rok_produkcji,
    p.cena_katalogowa,
    s.nazwa AS salon
FROM Pojazdy p
JOIN Modele_Samochodow m ON p.id_modelu = m.id_modelu
JOIN Producenci pr ON m.id_producenta = pr.id_producenta
JOIN Salony s ON p.nr_salonu = s.nr_salonu
WHERE p.status = 'Dostepny'
ORDER BY p.cena_katalogowa DESC;

SELECT 
    k.imie || ' ' || k.nazwisko AS klient,
    pr.nazwa_producenta || ' ' || m.nazwa_modelu AS pojazd,
    sp.cena_sprzedazy,
    sp.cena_koncowa,
    ROUND((sp.cena_sprzedazy - sp.cena_koncowa) / sp.cena_sprzedazy * 100, 2) AS rabat_procent,
    sp.data_sprzedazy
FROM Sprzedaze sp
JOIN Klienci k ON sp.nr_klienta = k.nr_klienta
JOIN Pojazdy p ON sp.nr_vin = p.nr_vin
JOIN Modele_Samochodow m ON p.id_modelu = m.id_modelu
JOIN Producenci pr ON m.id_producenta = pr.id_producenta
WHERE sp.status = 'Zakonczona'
ORDER BY sp.data_sprzedazy DESC;

SELECT 
    pra.imie || ' ' || pra.nazwisko AS sprzedawca,
    s.liczba_sprzedazy,
    s.prowizja_procent,
    NVL(SUM(sp.cena_koncowa), 0) AS suma_sprzedazy
FROM Sprzedawcy s
JOIN Pracownicy pra ON s.nr_pracownika = pra.nr_pracownika
LEFT JOIN Sprzedaze sp ON s.nr_pracownika = sp.nr_pracownika AND sp.status = 'Zakonczona'
GROUP BY pra.imie, pra.nazwisko, s.liczba_sprzedazy, s.prowizja_procent
ORDER BY s.liczba_sprzedazy DESC;

SPOOL OFF
