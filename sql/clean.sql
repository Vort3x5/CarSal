SET ECHO ON
SET FEEDBACK ON
SET PAGESIZE 1000
SET LINESIZE 200
SET TRIMSPOOL ON

SPOOL cleanup_and_verify.log

PROMPT ======================================
PROMPT CZYSZCZENIE RECYCLE BIN
PROMPT ======================================

PURGE RECYCLEBIN;

PROMPT Recycle Bin wyczyszczony!
PROMPT

PROMPT ======================================
PROMPT WERYFIKACJA - LICZBA REKORDOW
PROMPT ======================================

SELECT 'Salony' AS tabela, COUNT(*) AS liczba FROM Salony
UNION ALL
SELECT 'Producenci', COUNT(*) FROM Producenci
UNION ALL
SELECT 'Modele_Samochodow', COUNT(*) FROM Modele_Samochodow
UNION ALL
SELECT 'Pojazdy', COUNT(*) FROM Pojazdy
UNION ALL
SELECT 'Klienci', COUNT(*) FROM Klienci
UNION ALL
SELECT 'Pracownicy', COUNT(*) FROM Pracownicy
UNION ALL
SELECT 'Sprzedawcy', COUNT(*) FROM Sprzedawcy
UNION ALL
SELECT 'Serwisanci', COUNT(*) FROM Serwisanci
UNION ALL
SELECT 'Certyfikaty_Serwisanta', COUNT(*) FROM Certyfikaty_Serwisanta
UNION ALL
SELECT 'Sprzedaze', COUNT(*) FROM Sprzedaze
UNION ALL
SELECT 'Wyposazenie', COUNT(*) FROM Wyposazenie
UNION ALL
SELECT 'Pojazdy_Wyposazenie', COUNT(*) FROM Pojazdy_Wyposazenie
UNION ALL
SELECT 'Jazdy_Testowe', COUNT(*) FROM Jazdy_Testowe;

PROMPT
PROMPT Oczekiwane wartosci:
PROMPT Salony: 3
PROMPT Producenci: 7
PROMPT Modele_Samochodow: 21
PROMPT Pojazdy: 11
PROMPT Klienci: 8
PROMPT Pracownicy: 7
PROMPT Sprzedawcy: 4
PROMPT Serwisanci: 3
PROMPT Certyfikaty_Serwisanta: 5
PROMPT Sprzedaze: 3
PROMPT Wyposazenie: 12
PROMPT Pojazdy_Wyposazenie: 12
PROMPT Jazdy_Testowe: 5
PROMPT

PROMPT ======================================
PROMPT WERYFIKACJA - TABELE
PROMPT ======================================

SELECT table_name, num_rows, last_analyzed 
FROM user_tables 
ORDER BY table_name;

PROMPT ======================================
PROMPT WERYFIKACJA - CONSTRAINTY (tylko aktywne tabele)
PROMPT ======================================

SELECT 
    constraint_name,
    table_name,
    CASE constraint_type
        WHEN 'P' THEN 'PRIMARY KEY'
        WHEN 'R' THEN 'FOREIGN KEY'
        WHEN 'U' THEN 'UNIQUE'
        WHEN 'C' THEN 'CHECK'
    END AS typ,
    status
FROM user_constraints
WHERE constraint_type IN ('R', 'P', 'U', 'C')
  AND table_name NOT LIKE 'BIN$%'
ORDER BY table_name, constraint_type;

PROMPT ======================================
PROMPT WERYFIKACJA - TRIGGERY
PROMPT ======================================

SELECT 
    trigger_name,
    table_name,
    status,
    triggering_event
FROM user_triggers
ORDER BY table_name, trigger_name;

PROMPT ======================================
PROMPT WERYFIKACJA - PROCEDURY I FUNKCJE
PROMPT ======================================

SELECT 
    object_name,
    object_type,
    status
FROM user_objects
WHERE object_type IN ('PROCEDURE', 'FUNCTION')
ORDER BY object_type, object_name;

PROMPT ======================================
PROMPT WERYFIKACJA - SEKWENCJE
PROMPT ======================================

SELECT sequence_name, last_number 
FROM user_sequences 
ORDER BY sequence_name;

PROMPT ======================================
PROMPT PODSUMOWANIE
PROMPT ======================================

SELECT 'Tabele' AS obiekt, COUNT(*) AS liczba FROM user_tables
UNION ALL
SELECT 'Sekwencje', COUNT(*) FROM user_sequences
UNION ALL
SELECT 'Triggery (ENABLED)', COUNT(*) FROM user_triggers WHERE status = 'ENABLED'
UNION ALL
SELECT 'Constrainty (ENABLED)', COUNT(*) FROM user_constraints WHERE status = 'ENABLED' AND table_name NOT LIKE 'BIN$%'
UNION ALL
SELECT 'Procedury/Funkcje (VALID)', COUNT(*) FROM user_objects WHERE object_type IN ('PROCEDURE', 'FUNCTION') AND status = 'VALID'
UNION ALL
SELECT 'Indeksy', COUNT(*) FROM user_indexes WHERE table_name NOT LIKE 'BIN$%';

PROMPT
PROMPT ======================================
PROMPT TEST - PRZYKLADOWE ZAPYTANIE
PROMPT ======================================

SELECT 
    pr.nazwa_producenta,
    m.nazwa_modelu,
    p.kolor,
    p.cena_katalogowa,
    p.status
FROM Pojazdy p
JOIN Modele_Samochodow m ON p.id_modelu = m.id_modelu
JOIN Producenci pr ON m.id_producenta = pr.id_producenta
WHERE p.status = 'Dostepny'
ORDER BY p.cena_katalogowa DESC
FETCH FIRST 5 ROWS ONLY;

PROMPT
PROMPT ======================================
PROMPT SPRAWDZENIE - CZY JEST JAKIS BLAD?
PROMPT ======================================

SELECT 'INVALID Objects' AS problem, COUNT(*) AS liczba
FROM user_objects 
WHERE status = 'INVALID'
UNION ALL
SELECT 'DISABLED Triggers', COUNT(*)
FROM user_triggers 
WHERE status = 'DISABLED'
UNION ALL
SELECT 'DISABLED Constraints', COUNT(*)
FROM user_constraints 
WHERE status = 'DISABLED' AND table_name NOT LIKE 'BIN$%';

SPOOL OFF

PROMPT
PROMPT ======================================
PROMPT Weryfikacja zakonczona!
PROMPT Wyniki zapisane w: cleanup_and_verify.log
PROMPT ======================================
PROMPT

EXIT;
