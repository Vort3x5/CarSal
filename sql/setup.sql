-- ==============================================
-- Setup użytkownika SALON_ADMIN w XEPDB1
-- Wykonaj jako SYSTEM
-- ==============================================

-- Połącz się z Pluggable Database
ALTER SESSION SET CONTAINER = XEPDB1;

-- Usuń użytkownika jeśli istnieje
BEGIN
    EXECUTE IMMEDIATE 'DROP USER salon_admin CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/

-- Utwórz użytkownika
CREATE USER salon_admin IDENTIFIED BY salon123
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON USERS;

-- Nadaj uprawnienia
GRANT CONNECT, RESOURCE TO salon_admin;
GRANT CREATE SESSION TO salon_admin;
GRANT CREATE TABLE TO salon_admin;
GRANT CREATE SEQUENCE TO salon_admin;
GRANT CREATE TRIGGER TO salon_admin;
GRANT CREATE PROCEDURE TO salon_admin;
GRANT CREATE VIEW TO salon_admin;
GRANT CREATE SYNONYM TO salon_admin;

-- Potwierdzenie
SELECT username, account_status, default_tablespace 
FROM dba_users 
WHERE username = 'SALON_ADMIN';

PROMPT
PROMPT ========================================
PROMPT Uzytkownik SALON_ADMIN utworzony!
PROMPT Polacz sie: sqlplus salon_admin/salon123@XEPDB1
PROMPT ========================================
PROMPT

EXIT;
