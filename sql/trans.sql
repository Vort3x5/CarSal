-- ==============================================
-- Transakcje biznesowe - Procedury składowane
-- Sekcja 5.1 dokumentacji
-- ==============================================

SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON

PROMPT ========================================
PROMPT Tworzenie procedur składowanych
PROMPT ========================================
PROMPT

-- ==============================================
-- PROCEDURA 1: Rejestracja nowego klienta
-- ==============================================

CREATE OR REPLACE PROCEDURE proc_dodaj_klienta_indywidualnego(
    p_imie IN VARCHAR2,
    p_nazwisko IN VARCHAR2,
    p_pesel IN CHAR,
    p_telefon IN VARCHAR2,
    p_email IN VARCHAR2,
    p_ulica IN VARCHAR2,
    p_miasto IN VARCHAR2,
    p_kod_pocztowy IN CHAR,
    p_nr_klienta OUT NUMBER
) AS
BEGIN
    INSERT INTO Klienci (
        typ_klienta, imie, nazwisko, pesel, 
        telefon, email, ulica, miasto, kod_pocztowy
    ) VALUES (
        'Indywidualny', p_imie, p_nazwisko, p_pesel,
        p_telefon, p_email, p_ulica, p_miasto, p_kod_pocztowy
    ) RETURNING nr_klienta INTO p_nr_klienta;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Klient dodany: ID = ' || p_nr_klienta);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Klient z tym PESEL już istnieje');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

PROMPT === Procedura: proc_dodaj_klienta_indywidualnego ===
PROMPT

-- ==============================================
-- PROCEDURA 2: Realizacja sprzedaży pojazdu
-- ==============================================

CREATE OR REPLACE PROCEDURE proc_sprzedaj_pojazd(
    p_nr_vin IN CHAR,
    p_nr_klienta IN NUMBER,
    p_nr_sprzedawcy IN NUMBER,
    p_cena_koncowa IN NUMBER,
    p_metoda_platnosci IN VARCHAR2,
    p_nr_sprzedazy OUT NUMBER
) AS
    v_cena_katalogowa NUMBER(10,2);
    v_limit_rabatu NUMBER(5,2);
    v_rabat_procent NUMBER(5,2);
    v_status_pojazdu VARCHAR2(15);
BEGIN
    -- Sprawdź dostępność pojazdu
    SELECT status, cena_katalogowa 
    INTO v_status_pojazdu, v_cena_katalogowa
    FROM Pojazdy 
    WHERE nr_vin = p_nr_vin;
    
    IF v_status_pojazdu != 'Dostepny' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Pojazd nie jest dostępny do sprzedaży');
    END IF;
    
    -- Sprawdź limit rabatu sprzedawcy
    SELECT limit_rabatu_procent 
    INTO v_limit_rabatu
    FROM Sprzedawcy 
    WHERE nr_pracownika = p_nr_sprzedawcy;
    
    v_rabat_procent := ((v_cena_katalogowa - p_cena_koncowa) / v_cena_katalogowa) * 100;
    
    IF v_rabat_procent > v_limit_rabatu THEN
        RAISE_APPLICATION_ERROR(-20003, 
            'Rabat ' || ROUND(v_rabat_procent, 2) || '% przekracza limit sprzedawcy ' || v_limit_rabatu || '%');
    END IF;
    
    -- Wstaw sprzedaż
    INSERT INTO Sprzedaze (
        nr_vin, nr_klienta, nr_pracownika,
        data_sprzedazy, cena_sprzedazy, cena_koncowa,
        metoda_platnosci, status
    ) VALUES (
        p_nr_vin, p_nr_klienta, p_nr_sprzedawcy,
        SYSDATE, v_cena_katalogowa, p_cena_koncowa,
        p_metoda_platnosci, 'W_trakcie'
    ) RETURNING nr_sprzedazy INTO p_nr_sprzedazy;
    
    -- Aktualizuj status pojazdu
    UPDATE Pojazdy 
    SET status = 'Sprzedany' 
    WHERE nr_vin = p_nr_vin;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Sprzedaż zarejestrowana: ID = ' || p_nr_sprzedazy);
    DBMS_OUTPUT.PUT_LINE('Rabat udzielony: ' || ROUND(v_rabat_procent, 2) || '%');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004, 'Pojazd lub sprzedawca nie istnieje');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

PROMPT === Procedura: proc_sprzedaj_pojazd ===
PROMPT

-- ==============================================
-- PROCEDURA 3: Rezerwacja jazdy testowej
-- ==============================================

CREATE OR REPLACE PROCEDURE proc_zarezerwuj_jazde_testowa(
    p_nr_klienta IN NUMBER,
    p_nr_vin IN CHAR,
    p_data_jazdy IN DATE,
    p_godzina_jazdy IN TIMESTAMP,
    p_nr_prawa_jazdy IN VARCHAR2,
    p_nr_jazdy OUT NUMBER
) AS
    v_status_pojazdu VARCHAR2(15);
    v_liczba_jazd NUMBER;
BEGIN
    -- Sprawdź dostępność pojazdu
    SELECT status INTO v_status_pojazdu
    FROM Pojazdy 
    WHERE nr_vin = p_nr_vin;
    
    IF v_status_pojazdu NOT IN ('Dostepny', 'Rezerwacja') THEN
        RAISE_APPLICATION_ERROR(-20005, 'Pojazd nie jest dostępny do jazd testowych');
    END IF;
    
    -- Sprawdź czy pojazd nie jest już zarezerwowany w tym czasie
    SELECT COUNT(*) INTO v_liczba_jazd
    FROM Jazdy_Testowe
    WHERE nr_vin = p_nr_vin 
      AND data_jazdy = p_data_jazdy
      AND status = 'Zarezerwowana';
    
    IF v_liczba_jazd > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Pojazd już zarezerwowany w tym terminie');
    END IF;
    
    -- Wstaw rezerwację
    INSERT INTO Jazdy_Testowe (
        nr_klienta, nr_vin, data_jazdy,
        godzina_jazdy, nr_prawa_jazdy, status
    ) VALUES (
        p_nr_klienta, p_nr_vin, p_data_jazdy,
        p_godzina_jazdy, p_nr_prawa_jazdy, 'Zarezerwowana'
    ) RETURNING nr_jazdy INTO p_nr_jazdy;
    
    -- Aktualizuj status pojazdu
    UPDATE Pojazdy 
    SET status = 'Rezerwacja' 
    WHERE nr_vin = p_nr_vin AND status = 'Dostepny';
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Jazda testowa zarezerwowana: ID = ' || p_nr_jazdy);
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

PROMPT === Procedura: proc_zarezerwuj_jazde_testowa ===
PROMPT

-- ==============================================
-- PROCEDURA 4: Zakończenie jazdy testowej
-- ==============================================

CREATE OR REPLACE PROCEDURE proc_zakoncz_jazde_testowa(
    p_nr_jazdy IN NUMBER
) AS
    v_nr_vin CHAR(17);
    v_liczba_rezerwacji NUMBER;
BEGIN
    -- Pobierz VIN pojazdu
    SELECT nr_vin INTO v_nr_vin
    FROM Jazdy_Testowe
    WHERE nr_jazdy = p_nr_jazdy;
    
    -- Zaktualizuj status jazdy
    UPDATE Jazdy_Testowe
    SET status = 'Odbyta'
    WHERE nr_jazdy = p_nr_jazdy;
    
    -- Sprawdź czy są jeszcze inne rezerwacje dla tego pojazdu
    SELECT COUNT(*) INTO v_liczba_rezerwacji
    FROM Jazdy_Testowe
    WHERE nr_vin = v_nr_vin 
      AND status = 'Zarezerwowana';
    
    -- Jeśli brak rezerwacji, przywróć status Dostepny
    IF v_liczba_rezerwacji = 0 THEN
        UPDATE Pojazdy
        SET status = 'Dostepny'
        WHERE nr_vin = v_nr_vin AND status = 'Rezerwacja';
    END IF;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Jazda testowa zakończona: ID = ' || p_nr_jazdy);
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

PROMPT === Procedura: proc_zakoncz_jazde_testowa ===
PROMPT

-- ==============================================
-- FUNKCJA: Obliczanie prowizji sprzedawcy
-- ==============================================

CREATE OR REPLACE FUNCTION func_oblicz_prowizje(
    p_nr_sprzedawcy IN NUMBER,
    p_miesiac IN NUMBER,
    p_rok IN NUMBER
) RETURN NUMBER AS
    v_prowizja_procent NUMBER(5,2);
    v_suma_sprzedazy NUMBER(10,2);
    v_prowizja NUMBER(10,2);
BEGIN
    -- Pobierz procent prowizji
    SELECT prowizja_procent INTO v_prowizja_procent
    FROM Sprzedawcy
    WHERE nr_pracownika = p_nr_sprzedawcy;
    
    -- Oblicz sumę sprzedaży w miesiącu
    SELECT NVL(SUM(cena_koncowa), 0) INTO v_suma_sprzedazy
    FROM Sprzedaze
    WHERE nr_pracownika = p_nr_sprzedawcy
      AND EXTRACT(MONTH FROM data_sprzedazy) = p_miesiac
      AND EXTRACT(YEAR FROM data_sprzedazy) = p_rok
      AND status = 'Zakonczona';
    
    v_prowizja := v_suma_sprzedazy * (v_prowizja_procent / 100);
    
    RETURN v_prowizja;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/

PROMPT === Funkcja: func_oblicz_prowizje ===
PROMPT

-- ==============================================
-- WERYFIKACJA PROCEDUR
-- ==============================================

PROMPT
PROMPT === Lista procedur i funkcji ===
SELECT object_name, object_type, status
FROM user_objects
WHERE object_type IN ('PROCEDURE', 'FUNCTION')
ORDER BY object_type, object_name;

PROMPT
PROMPT ========================================
PROMPT Procedury utworzone pomyślnie!
PROMPT ========================================
