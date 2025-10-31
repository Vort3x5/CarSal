SET ECHO ON
SET FEEDBACK ON
SET LINESIZE 150
SET PAGESIZE 100

PROMPT ========================================
PROMPT Przykładowe zapytania SQL
PROMPT ========================================
PROMPT

PROMPT === Q1: Dostępne pojazdy z informacją o modelu ===
SELECT 
    p.nr_vin,
    pr.nazwa_producenta || ' ' || m.nazwa_modelu AS pojazd,
    p.rok_produkcji,
    p.przebieg,
    p.kolor,
    p.cena_katalogowa,
    p.stan,
    s.nazwa AS salon
FROM Pojazdy p
JOIN Modele_Samochodow m ON p.id_modelu = m.id_modelu
JOIN Producenci pr ON m.id_producenta = pr.id_producenta
JOIN Salony s ON p.nr_salonu = s.nr_salonu
WHERE p.status = 'Dostepny'
ORDER BY p.cena_katalogowa;

PROMPT

PROMPT === Q2: Historia sprzedaży z danymi klienta ===
SELECT 
    sp.nr_sprzedazy,
    sp.data_sprzedazy,
    k.imie || ' ' || k.nazwisko AS klient,
    pr.imie || ' ' || pr.nazwisko AS sprzedawca,
    prod.nazwa_producenta || ' ' || m.nazwa_modelu AS pojazd,
    sp.cena_sprzedazy AS cena_wyjsciowa,
    sp.cena_koncowa,
    sp.cena_sprzedazy - sp.cena_koncowa AS rabat,
    ROUND((sp.cena_sprzedazy - sp.cena_koncowa) / sp.cena_sprzedazy * 100, 2) AS rabat_procent,
    sp.metoda_platnosci,
    sp.status
FROM Sprzedaze sp
JOIN Klienci k ON sp.nr_klienta = k.nr_klienta
JOIN Pracownicy pr ON sp.nr_pracownika = pr.nr_pracownika
JOIN Pojazdy poj ON sp.nr_vin = poj.nr_vin
JOIN Modele_Samochodow m ON poj.id_modelu = m.id_modelu
JOIN Producenci prod ON m.id_producenta = prod.id_producenta
ORDER BY sp.data_sprzedazy DESC;

PROMPT

PROMPT === Q3: Ranking sprzedawców według liczby sprzedaży ===
SELECT 
    p.imie || ' ' || p.nazwisko AS sprzedawca,
    s.liczba_sprzedazy,
    s.prowizja_procent,
    COUNT(sp.nr_sprzedazy) AS zrealizowane_sprzedaze,
    NVL(SUM(sp.cena_koncowa), 0) AS laczna_wartosc,
    NVL(ROUND(SUM(sp.cena_koncowa) * (s.prowizja_procent / 100), 2), 0) AS prowizja
FROM Pracownicy p
JOIN Sprzedawcy s ON p.nr_pracownika = s.nr_pracownika
LEFT JOIN Sprzedaze sp ON s.nr_pracownika = sp.nr_pracownika 
    AND sp.status = 'Zakonczona'
GROUP BY p.imie, p.nazwisko, s.liczba_sprzedazy, s.prowizja_procent
ORDER BY laczna_wartosc DESC;

PROMPT

PROMPT === Q4: Pojazdy z pełnym wyposażeniem ===
SELECT 
    prod.nazwa_producenta || ' ' || m.nazwa_modelu AS pojazd,
    p.nr_vin,
    p.rok_produkcji,
    p.cena_katalogowa,
    LISTAGG(w.nazwa, ', ') WITHIN GROUP (ORDER BY w.nazwa) AS wyposazenie,
    p.cena_katalogowa + NVL(SUM(w.dodatkowa_cena), 0) AS cena_z_wyposazeniem
FROM Pojazdy p
JOIN Modele_Samochodow m ON p.id_modelu = m.id_modelu
JOIN Producenci prod ON m.id_producenta = prod.id_producenta
LEFT JOIN Pojazdy_Wyposazenie pw ON p.nr_vin = pw.nr_vin
LEFT JOIN Wyposazenie w ON pw.id_wyposazenia = w.id_wyposazenia
WHERE p.status = 'Dostepny'
GROUP BY prod.nazwa_producenta, m.nazwa_modelu, p.nr_vin, 
         p.rok_produkcji, p.cena_katalogowa
ORDER BY pojazd;

PROMPT

PROMPT === Q5: Statystyki sprzedaży według salonów ===
SELECT 
    s.nazwa AS salon,
    s.miasto,
    COUNT(DISTINCT poj.nr_vin) AS liczba_pojazdow,
    COUNT(DISTINCT CASE WHEN poj.status = 'Dostepny' THEN poj.nr_vin END) AS dostepne,
    COUNT(DISTINCT CASE WHEN poj.status = 'Sprzedany' THEN poj.nr_vin END) AS sprzedane,
    COUNT(DISTINCT pr.nr_pracownika) AS liczba_pracownikow,
    NVL(SUM(sp.cena_koncowa), 0) AS laczna_sprzedaz
FROM Salony s
LEFT JOIN Pojazdy poj ON s.nr_salonu = poj.nr_salonu
LEFT JOIN Pracownicy pr ON s.nr_salonu = pr.nr_salonu
LEFT JOIN Sprzedaze sp ON poj.nr_vin = sp.nr_vin AND sp.status = 'Zakonczona'
GROUP BY s.nazwa, s.miasto
ORDER BY laczna_sprzedaz DESC;

PROMPT

PROMPT === Q6: Jazdy testowe i efektywność konwersji ===
SELECT 
    prod.nazwa_producenta || ' ' || m.nazwa_modelu AS pojazd,
    COUNT(jt.nr_jazdy) AS liczba_jazd_testowych,
    COUNT(DISTINCT CASE WHEN jt.status = 'Odbyta' THEN jt.nr_jazdy END) AS odbyte,
    COUNT(DISTINCT sp.nr_sprzedazy) AS sprzedane,
    ROUND(
        CASE 
            WHEN COUNT(jt.nr_jazdy) > 0 
            THEN (COUNT(DISTINCT sp.nr_sprzedazy) / COUNT(jt.nr_jazdy)) * 100 
            ELSE 0 
        END, 
        2
    ) AS wspolczynnik_konwersji_procent
FROM Pojazdy p
JOIN Modele_Samochodow m ON p.id_modelu = m.id_modelu
JOIN Producenci prod ON m.id_producenta = prod.id_producenta
LEFT JOIN Jazdy_Testowe jt ON p.nr_vin = jt.nr_vin
LEFT JOIN Sprzedaze sp ON p.nr_vin = sp.nr_vin
GROUP BY prod.nazwa_producenta, m.nazwa_modelu
HAVING COUNT(jt.nr_jazdy) > 0
ORDER BY wspolczynnik_konwersji_procent DESC;

PROMPT

PROMPT === Q7: Serwisanci i ich certyfikaty ===
SELECT 
    p.imie || ' ' || p.nazwisko AS serwisant,
    srv.specjalizacja,
    srv.stawka_godzinowa,
    COUNT(c.id_certyfikatu) AS liczba_certyfikatow,
    LISTAGG(c.certyfikat, '; ') WITHIN GROUP (ORDER BY c.data_uzyskania) AS certyfikaty
FROM Pracownicy p
JOIN Serwisanci srv ON p.nr_pracownika = srv.nr_pracownika
LEFT JOIN Certyfikaty_Serwisanta c ON srv.nr_pracownika = c.nr_pracownika
GROUP BY p.imie, p.nazwisko, srv.specjalizacja, srv.stawka_godzinowa
ORDER BY liczba_certyfikatow DESC, serwisant;

PROMPT

PROMPT === Q8: Najpopularniejsze modele (sprzedaż) ===
SELECT 
    prod.nazwa_producenta,
    m.nazwa_modelu,
    m.typ_nadwozia,
    COUNT(sp.nr_sprzedazy) AS liczba_sprzedanych,
    NVL(AVG(sp.cena_koncowa), 0) AS srednia_cena,
    NVL(MIN(sp.cena_koncowa), 0) AS min_cena,
    NVL(MAX(sp.cena_koncowa), 0) AS max_cena
FROM Modele_Samochodow m
JOIN Producenci prod ON m.id_producenta = prod.id_producenta
LEFT JOIN Pojazdy p ON m.id_modelu = p.id_modelu
LEFT JOIN Sprzedaze sp ON p.nr_vin = sp.nr_vin AND sp.status = 'Zakonczona'
GROUP BY prod.nazwa_producenta, m.nazwa_modelu, m.typ_nadwozia
HAVING COUNT(sp.nr_sprzedazy) > 0
ORDER BY liczba_sprzedanych DESC, srednia_cena DESC;

PROMPT

PROMPT === Q9: Klienci i ich historia zakupów ===
SELECT 
    k.nr_klienta,
    CASE 
        WHEN k.typ_klienta = 'Indywidualny' THEN k.imie || ' ' || k.nazwisko
        ELSE k.nazwa_firmy
    END AS klient,
    k.typ_klienta,
    k.miasto,
    COUNT(sp.nr_sprzedazy) AS liczba_zakupow,
    NVL(SUM(sp.cena_koncowa), 0) AS laczna_wartosc_zakupow,
    MAX(sp.data_sprzedazy) AS ostatni_zakup
FROM Klienci k
LEFT JOIN Sprzedaze sp ON k.nr_klienta = sp.nr_klienta
GROUP BY k.nr_klienta, k.imie, k.nazwisko, k.nazwa_firmy, k.typ_klienta, k.miasto
ORDER BY laczna_wartosc_zakupow DESC;

PROMPT

PROMPT === Q10: Analiza udzielonych rabatów ===
SELECT 
    p.imie || ' ' || p.nazwisko AS sprzedawca,
    s.limit_rabatu_procent,
    COUNT(sp.nr_sprzedazy) AS liczba_sprzedazy,
    ROUND(AVG((sp.cena_sprzedazy - sp.cena_koncowa) / sp.cena_sprzedazy * 100), 2) AS sredni_rabat_procent,
    ROUND(MAX((sp.cena_sprzedazy - sp.cena_koncowa) / sp.cena_sprzedazy * 100), 2) AS max_rabat_procent,
    SUM(sp.cena_sprzedazy - sp.cena_koncowa) AS laczna_wartosc_rabatow
FROM Pracownicy p
JOIN Sprzedawcy s ON p.nr_pracownika = s.nr_pracownika
LEFT JOIN Sprzedaze sp ON s.nr_pracownika = sp.nr_pracownika 
    AND sp.status = 'Zakonczona'
GROUP BY p.imie, p.nazwisko, s.limit_rabatu_procent
HAVING COUNT(sp.nr_sprzedazy) > 0
ORDER BY sredni_rabat_procent DESC;
