SET ECHO ON
SET FEEDBACK ON
SPOOL logs/01_create_schema.log

BEGIN
   FOR r IN (SELECT table_name FROM user_tables) LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || r.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;
   FOR r IN (SELECT sequence_name FROM user_sequences) LOOP
      EXECUTE IMMEDIATE 'DROP SEQUENCE ' || r.sequence_name;
   END LOOP;
END;
/

CREATE SEQUENCE seq_salony START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_producenci START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_modele START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_klienci START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_pracownicy START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_sprzedaze START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_wyposazenie START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_jazdy_testowe START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_certyfikaty START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE TABLE Salony (
    nr_salonu NUMBER(5) PRIMARY KEY,
    nazwa VARCHAR2(100) NOT NULL UNIQUE,
    ulica VARCHAR2(100) NOT NULL,
    miasto VARCHAR2(50) NOT NULL,
    kod_pocztowy CHAR(6) NOT NULL,
    telefon VARCHAR2(15),
    email VARCHAR2(100),
    CONSTRAINT ck_salony_kod CHECK (REGEXP_LIKE(kod_pocztowy, '^\d{2}-\d{3}$'))
);

CREATE TABLE Producenci (
    id_producenta NUMBER(5) PRIMARY KEY,
    nazwa_producenta VARCHAR2(50) NOT NULL UNIQUE,
    kraj_pochodzenia VARCHAR2(50)
);

CREATE TABLE Modele_Samochodow (
    id_modelu NUMBER(10) PRIMARY KEY,
    id_producenta NUMBER(5) NOT NULL,
    nazwa_modelu VARCHAR2(50) NOT NULL,
    typ_nadwozia VARCHAR2(15) NOT NULL,
    pojemnosc_silnika NUMBER(3,1),
    moc_km NUMBER(4),
    rodzaj_paliwa VARCHAR2(15) NOT NULL,
    liczba_miejsc NUMBER(1),
    CONSTRAINT fk_modele_producent FOREIGN KEY (id_producenta) 
        REFERENCES Producenci(id_producenta),
    CONSTRAINT ck_modele_nadwozie CHECK (typ_nadwozia IN ('Sedan', 'SUV', 'Hatchback', 'Kombi')),
    CONSTRAINT ck_modele_paliwo CHECK (rodzaj_paliwa IN ('Benzyna', 'Diesel', 'Elektryczny', 'Hybryda')),
    CONSTRAINT ck_modele_miejsca CHECK (liczba_miejsc BETWEEN 2 AND 9)
);

CREATE TABLE Pojazdy (
    nr_vin CHAR(17) PRIMARY KEY,
    id_modelu NUMBER(10) NOT NULL,
    nr_salonu NUMBER(5) NOT NULL,
    rok_produkcji NUMBER(4) NOT NULL,
    przebieg NUMBER(10) DEFAULT 0,
    kolor VARCHAR2(30),
    cena_katalogowa NUMBER(10,2) NOT NULL,
    stan VARCHAR2(10) NOT NULL,
    status VARCHAR2(15) NOT NULL,
    data_przyjecia DATE DEFAULT SYSDATE,
    uwagi VARCHAR2(500),
	deleted NUMBER(1) DEFAULT 0 NOT NULL,
    CONSTRAINT fk_pojazdy_model FOREIGN KEY (id_modelu) 
        REFERENCES Modele_Samochodow(id_modelu),
    CONSTRAINT fk_pojazdy_salon FOREIGN KEY (nr_salonu) 
        REFERENCES Salony(nr_salonu),
    CONSTRAINT ck_pojazdy_rok CHECK (rok_produkcji BETWEEN 1900 AND 2025),
    CONSTRAINT ck_pojazdy_przebieg CHECK (przebieg >= 0),
    CONSTRAINT ck_pojazdy_cena CHECK (cena_katalogowa > 0),
    CONSTRAINT ck_pojazdy_stan CHECK (stan IN ('Nowy', 'Uzywany')),
    CONSTRAINT ck_pojazdy_status CHECK (status IN ('Dostepny', 'Sprzedany', 'Rezerwacja', 'Serwis')),
    CONSTRAINT ck_pojazdy_vin CHECK (LENGTH(nr_vin) = 17)
);

CREATE TABLE Klienci (
    nr_klienta NUMBER(10) PRIMARY KEY,
    typ_klienta VARCHAR2(15) NOT NULL,
    imie VARCHAR2(50),
    nazwisko VARCHAR2(50),
    pesel CHAR(11),
    nazwa_firmy VARCHAR2(100),
    nip CHAR(10),
    ulica VARCHAR2(100),
    miasto VARCHAR2(50),
    kod_pocztowy CHAR(6),
    telefon VARCHAR2(15) NOT NULL,
    email VARCHAR2(100),
    data_rejestracji DATE DEFAULT SYSDATE,
    CONSTRAINT ck_klient_typ CHECK (typ_klienta IN ('Indywidualny', 'Firma')),
    CONSTRAINT ck_klient_pesel CHECK (pesel IS NULL OR LENGTH(pesel) = 11),
    CONSTRAINT ck_klient_nip CHECK (nip IS NULL OR LENGTH(nip) = 10),
    CONSTRAINT uk_klient_pesel UNIQUE (pesel),
    CONSTRAINT uk_klient_nip UNIQUE (nip),
    CONSTRAINT uk_klient_email UNIQUE (email),
    CONSTRAINT ck_klient_indywidualny CHECK (
        (typ_klienta = 'Indywidualny' AND pesel IS NOT NULL) OR
        (typ_klienta = 'Firma' AND nip IS NOT NULL)
    )
);

CREATE TABLE Pracownicy (
    nr_pracownika NUMBER(7) PRIMARY KEY,
    nr_salonu NUMBER(5) NOT NULL,
    imie VARCHAR2(50) NOT NULL,
    nazwisko VARCHAR2(50) NOT NULL,
    pesel CHAR(11) NOT NULL UNIQUE,
    stanowisko VARCHAR2(50) NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    pensja_podstawowa NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_pracownicy_salon FOREIGN KEY (nr_salonu) 
        REFERENCES Salony(nr_salonu),
    CONSTRAINT ck_pracownicy_pesel CHECK (LENGTH(pesel) = 11),
    CONSTRAINT ck_pracownicy_pensja CHECK (pensja_podstawowa > 0)
);

CREATE TABLE Sprzedawcy (
    nr_pracownika NUMBER(7) PRIMARY KEY,
    prowizja_procent NUMBER(5,2),
    limit_rabatu_procent NUMBER(5,2),
    liczba_sprzedazy NUMBER(5) DEFAULT 0,
    CONSTRAINT fk_sprzedawcy_pracownik FOREIGN KEY (nr_pracownika) 
        REFERENCES Pracownicy(nr_pracownika) ON DELETE CASCADE,
    CONSTRAINT ck_sprzedawcy_prowizja CHECK (prowizja_procent BETWEEN 0 AND 100),
    CONSTRAINT ck_sprzedawcy_rabat CHECK (limit_rabatu_procent BETWEEN 0 AND 100),
    CONSTRAINT ck_sprzedawcy_liczba CHECK (liczba_sprzedazy >= 0)
);

CREATE TABLE Serwisanci (
    nr_pracownika NUMBER(7) PRIMARY KEY,
    specjalizacja VARCHAR2(100),
    stawka_godzinowa NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_serwisanci_pracownik FOREIGN KEY (nr_pracownika) 
        REFERENCES Pracownicy(nr_pracownika) ON DELETE CASCADE,
    CONSTRAINT ck_serwisanci_stawka CHECK (stawka_godzinowa > 0)
);

CREATE TABLE Certyfikaty_Serwisanta (
    id_certyfikatu NUMBER(10) PRIMARY KEY,
    nr_pracownika NUMBER(7) NOT NULL,
    certyfikat VARCHAR2(200) NOT NULL,
    data_uzyskania DATE DEFAULT SYSDATE,
    CONSTRAINT fk_certyfikaty_serwisant FOREIGN KEY (nr_pracownika) 
        REFERENCES Serwisanci(nr_pracownika) ON DELETE CASCADE
);

CREATE TABLE Sprzedaze (
    nr_sprzedazy NUMBER(10) PRIMARY KEY,
    nr_vin CHAR(17) NOT NULL UNIQUE,
    nr_klienta NUMBER(10) NOT NULL,
    nr_pracownika NUMBER(7) NOT NULL,
    data_sprzedazy DATE NOT NULL,
    cena_sprzedazy NUMBER(10,2) NOT NULL,
    cena_koncowa NUMBER(10,2) NOT NULL,
    metoda_platnosci VARCHAR2(20) NOT NULL,
    status VARCHAR2(15) NOT NULL,
    CONSTRAINT fk_sprzedaze_pojazd FOREIGN KEY (nr_vin) 
        REFERENCES Pojazdy(nr_vin),
    CONSTRAINT fk_sprzedaze_klient FOREIGN KEY (nr_klienta) 
        REFERENCES Klienci(nr_klienta),
    CONSTRAINT fk_sprzedaze_sprzedawca FOREIGN KEY (nr_pracownika) 
        REFERENCES Sprzedawcy(nr_pracownika),
    CONSTRAINT ck_sprzedaze_rabat CHECK (cena_koncowa <= cena_sprzedazy),
    CONSTRAINT ck_sprzedaze_platnosc CHECK (metoda_platnosci IN ('Gotowka', 'Przelew', 'Finansowanie', 'Leasing')),
    CONSTRAINT ck_sprzedaze_status CHECK (status IN ('W_trakcie', 'Zakonczona', 'Anulowana'))
);

CREATE TABLE Wyposazenie (
    id_wyposazenia NUMBER(10) PRIMARY KEY,
    nazwa VARCHAR2(100) NOT NULL UNIQUE,
    kategoria VARCHAR2(20),
    dodatkowa_cena NUMBER(10,2) DEFAULT 0,
    CONSTRAINT ck_wyposazenie_kategoria CHECK (kategoria IN ('Bezpieczenstwo', 'Komfort', 'Multimedia')),
    CONSTRAINT ck_wyposazenie_cena CHECK (dodatkowa_cena >= 0)
);

CREATE TABLE Pojazdy_Wyposazenie (
    nr_vin CHAR(17),
    id_wyposazenia NUMBER(10),
    CONSTRAINT pk_pojazdy_wyposazenie PRIMARY KEY (nr_vin, id_wyposazenia),  -- ✅
    CONSTRAINT fk_pw_pojazd FOREIGN KEY (nr_vin)
        REFERENCES Pojazdy(nr_vin) ON DELETE CASCADE,
    CONSTRAINT fk_pw_wyposazenie FOREIGN KEY (id_wyposazenia)
        REFERENCES Wyposazenie(id_wyposazenia) ON DELETE CASCADE
);

CREATE TABLE Jazdy_Testowe (
    nr_jazdy NUMBER(10) PRIMARY KEY,
    nr_klienta NUMBER(10) NOT NULL,
    nr_vin CHAR(17) NOT NULL,
    data_jazdy DATE NOT NULL,
    godzina_jazdy TIMESTAMP,
    nr_prawa_jazdy VARCHAR2(20),
    status VARCHAR2(20) DEFAULT 'Zarezerwowana',
    CONSTRAINT fk_jazdy_klient FOREIGN KEY (nr_klienta) 
        REFERENCES Klienci(nr_klienta),
    CONSTRAINT fk_jazdy_pojazd FOREIGN KEY (nr_vin) 
        REFERENCES Pojazdy(nr_vin),
    CONSTRAINT uk_jazdy_unikalne UNIQUE (nr_klienta, nr_vin, data_jazdy),
    CONSTRAINT ck_jazdy_status CHECK (status IN ('Zarezerwowana', 'Odbyta', 'Anulowana'))
);

CREATE OR REPLACE TRIGGER trg_salony_bi
BEFORE INSERT ON Salony
FOR EACH ROW
BEGIN
    IF :NEW.nr_salonu IS NULL THEN
        SELECT seq_salony.NEXTVAL INTO :NEW.nr_salonu FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_producenci_bi
BEFORE INSERT ON Producenci
FOR EACH ROW
BEGIN
    IF :NEW.id_producenta IS NULL THEN
        SELECT seq_producenci.NEXTVAL INTO :NEW.id_producenta FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_modele_bi
BEFORE INSERT ON Modele_Samochodow
FOR EACH ROW
BEGIN
    IF :NEW.id_modelu IS NULL THEN
        SELECT seq_modele.NEXTVAL INTO :NEW.id_modelu FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_klienci_bi
BEFORE INSERT ON Klienci
FOR EACH ROW
BEGIN
    IF :NEW.nr_klienta IS NULL THEN
        SELECT seq_klienci.NEXTVAL INTO :NEW.nr_klienta FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_pracownicy_bi
BEFORE INSERT ON Pracownicy
FOR EACH ROW
BEGIN
    IF :NEW.nr_pracownika IS NULL THEN
        SELECT seq_pracownicy.NEXTVAL INTO :NEW.nr_pracownika FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_sprzedaze_bi
BEFORE INSERT ON Sprzedaze
FOR EACH ROW
BEGIN
    IF :NEW.nr_sprzedazy IS NULL THEN
        SELECT seq_sprzedaze.NEXTVAL INTO :NEW.nr_sprzedazy FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_wyposazenie_bi
BEFORE INSERT ON Wyposazenie
FOR EACH ROW
BEGIN
    IF :NEW.id_wyposazenia IS NULL THEN
        SELECT seq_wyposazenie.NEXTVAL INTO :NEW.id_wyposazenia FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_jazdy_bi
BEFORE INSERT ON Jazdy_Testowe
FOR EACH ROW
BEGIN
    IF :NEW.nr_jazdy IS NULL THEN
        SELECT seq_jazdy_testowe.NEXTVAL INTO :NEW.nr_jazdy FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_certyfikaty_bi
BEFORE INSERT ON Certyfikaty_Serwisanta
FOR EACH ROW
BEGIN
    IF :NEW.id_certyfikatu IS NULL THEN
        SELECT seq_certyfikaty.NEXTVAL INTO :NEW.id_certyfikatu FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_sprzedaze_licznik
AFTER INSERT OR DELETE ON Sprzedaze
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE Sprzedawcy
        SET liczba_sprzedazy = liczba_sprzedazy + 1
        WHERE nr_pracownika = :NEW.nr_pracownika;
    ELSIF DELETING THEN
        UPDATE Sprzedawcy
        SET liczba_sprzedazy = GREATEST(liczba_sprzedazy - 1, 0)
        WHERE nr_pracownika = :OLD.nr_pracownika;
    END IF;
END;
/

SELECT table_name FROM user_tables ORDER BY table_name;
SELECT trigger_name, status FROM user_triggers ORDER BY trigger_name;

SPOOL OFF
