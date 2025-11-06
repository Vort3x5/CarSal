SET ECHO ON
SET FEEDBACK ON

CREATE INDEX idx_modele_producent ON Modele_Samochodow(id_producenta);

CREATE INDEX idx_pojazdy_model ON Pojazdy(id_modelu);
CREATE INDEX idx_pojazdy_salon ON Pojazdy(nr_salonu);

CREATE INDEX idx_pracownicy_salon ON Pracownicy(nr_salonu);

CREATE INDEX idx_sprzedaze_klient ON Sprzedaze(nr_klienta);
CREATE INDEX idx_sprzedaze_pracownik ON Sprzedaze(nr_pracownika);

CREATE INDEX idx_certyfikaty_pracownik ON Certyfikaty_Serwisanta(nr_pracownika);

CREATE INDEX idx_pw_wyposazenie ON Pojazdy_Wyposazenie(id_wyposazenia);

CREATE INDEX idx_jazdy_klient ON Jazdy_Testowe(nr_klienta);
CREATE INDEX idx_jazdy_pojazd ON Jazdy_Testowe(nr_vin);

CREATE INDEX idx_pojazdy_status ON Pojazdy(status);

CREATE INDEX idx_pojazdy_stan ON Pojazdy(stan);

CREATE INDEX idx_pojazdy_rok ON Pojazdy(rok_produkcji);

CREATE INDEX idx_klienci_typ ON Klienci(typ_klienta);

CREATE INDEX idx_sprzedaze_data ON Sprzedaze(data_sprzedazy);

CREATE INDEX idx_sprzedaze_status ON Sprzedaze(status);

CREATE INDEX idx_jazdy_data ON Jazdy_Testowe(data_jazdy);

CREATE INDEX idx_jazdy_status ON Jazdy_Testowe(status);

CREATE INDEX idx_pojazdy_status_stan ON Pojazdy(status, stan);

CREATE INDEX idx_pojazdy_salon_status ON Pojazdy(nr_salonu, status);

CREATE INDEX idx_sprzedaze_klient_data ON Sprzedaze(nr_klienta, data_sprzedazy);

CREATE INDEX idx_jazdy_pojazd_data ON Jazdy_Testowe(nr_vin, data_jazdy);

CREATE INDEX idx_klienci_nazwisko_upper ON Klienci(UPPER(nazwisko));

CREATE INDEX idx_salony_nazwa_upper ON Salony(UPPER(nazwa));

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
