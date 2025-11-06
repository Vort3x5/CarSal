SET PAGESIZE 1000
SET LINESIZE 200
SPOOL res.log

SELECT 'Salony' AS tabela, COUNT(*) AS liczba FROM Salony
UNION ALL
SELECT 'Producenci' AS tabela, COUNT(*) AS liczba FROM Producenci
UNION ALL
SELECT 'Modele_Samochodow' AS tabela, COUNT(*) AS liczba FROM Modele_Samochodow
UNION ALL
SELECT 'Pojazdy' AS tabela, COUNT(*) AS liczba FROM Pojazdy
UNION ALL
SELECT 'Klienci' AS tabela, COUNT(*) AS liczba FROM Klienci
UNION ALL
SELECT 'Pracownicy' AS tabela, COUNT(*) AS liczba FROM Pracownicy
UNION ALL
SELECT 'Sprzedawcy' AS tabela, COUNT(*) AS liczba FROM Sprzedawcy
UNION ALL
SELECT 'Serwisanci' AS tabela, COUNT(*) AS liczba FROM Serwisanci
UNION ALL
SELECT 'Certyfikaty_Serwisanta' AS tabela, COUNT(*) AS liczba FROM Certyfikaty_Serwisanta
UNION ALL
SELECT 'Sprzedaze' AS tabela, COUNT(*) AS liczba FROM Sprzedaze
UNION ALL
SELECT 'Wyposazenie' AS tabela, COUNT(*) AS liczba FROM Wyposazenie
UNION ALL
SELECT 'Pojazdy_Wyposazenie' AS tabela, COUNT(*) AS liczba FROM Pojazdy_Wyposazenie
UNION ALL
SELECT 'Jazdy_Testowe' AS tabela, COUNT(*) AS liczba FROM Jazdy_Testowe
ORDER BY tabela;

SELECT 
    constraint_name,
    table_name,
    constraint_type,
    status
FROM user_constraints
WHERE constraint_type IN ('R', 'P', 'U', 'C')
  AND table_name NOT LIKE 'BIN$%'
ORDER BY table_name, constraint_type;

SPOOL OFF
EXIT;
