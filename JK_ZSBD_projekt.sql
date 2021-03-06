-- 1. PRZYGOTOWANIE ODPOWIEDNIEJ STRUKTURY BAZY DANYCH NA WYBRANY TEMAT
-- TABELE GLOWNE

CREATE TABLE UZYTKOWNICY
(
    ID_UZYTKOWNIKA  INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    USERNAME     	VARCHAR2(30) NOT NULL,
    HASLO	     	VARCHAR2(30) NOT NULL,
    EMAIL        	VARCHAR2(30) NOT NULL,
    IMIE   		 	VARCHAR2(30) NOT NULL,
    NAZWISKO  	 	VARCHAR2(30) NOT NULL,
    TELEFON		 	VARCHAR2(30) NOT NULL,
    ID_ROLI      	INT          NOT NULL,
	ID_KLASY    	INT          NOT NULL,
	ID_SZKOLY    	INT          NOT NULL,
    FOREIGN KEY (ID_KLASY) REFERENCES KLASA (ID_KLASY),
	FOREIGN KEY (ID_ROLI) REFERENCES USER_ROLE (ID_ROLI),
	FOREIGN KEY (ID_SZKOLY) REFERENCES SZKOLA (ID_SZKOLY)
);

CREATE TABLE KLASA
(
	ID_KLASY  	INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
	NAZWA     	VARCHAR2(30) NOT NULL,
	ID_SZKOLY   INT          NOT NULL,
    FOREIGN KEY (ID_SZKOLY) REFERENCES SZKOLA (ID_SZKOLY)
);

CREATE TABLE SZKOLA
(
	ID_SZKOLY   INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
	NAZWA     	VARCHAR2(30) NOT NULL,
	OPIS     	VARCHAR2(30) NOT NULL
);

CREATE TABLE USER_ROLE
(
    ID_ROLI INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    ROLA    VARCHAR2(30) NOT NULL
);

CREATE TABLE UPRAWNIENIA
(
    ID_UPR INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    ID_ROLI           INT,
    ID_UZYTKOWNIKA    INT,
    FOREIGN KEY (ID_ROLI) REFERENCES USER_ROLE (ID_ROLI),
    FOREIGN KEY (ID_UZYTKOWNIKA) REFERENCES UZYTKOWNICY (ID_UZYTKOWNIKA)
);

CREATE TABLE ODPOWIEDZI
(
	ID_ODP   	INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
	NAZWA     	VARCHAR2(30) NOT NULL
);

CREATE TABLE DZIAL
(
	ID_DZIALU   	INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
	NAZWA     		VARCHAR2(30) NOT NULL,
    ID_PRZEDMIOTU   INT			 NOT NULL,
    FOREIGN KEY (ID_PRZEDMIOTU) REFERENCES PRZEDMIOT (ID_PRZEDMIOTU)
);

CREATE TABLE PRZEDMIOT
(
	ID_PRZEDMIOTU   INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
	NAZWA     		VARCHAR2(30) NOT NULL,
    ID_KLASY   		INT		NOT NULL,
	ID_SZKOLY   	INT		NOT NULL,
    FOREIGN KEY (ID_KLASY) REFERENCES KLASA (ID_KLASY),
	FOREIGN KEY (ID_SZKOLY) REFERENCES SZKOLA (ID_SZKOLY)
);

CREATE TABLE PYTANIE
(
	ID_PYTANIA	    INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    ID_KLASY   		INT,
	ID_SZKOLY   	INT,
	ID_UZYTKOWNIKA	INT				NOT NULL,
	TRESC           VARCHAR2(100) 	NOT NULL,
	ID_DZIALU		INT,
	ID_PRZEDMIOTU	INT,
	ID_POPRAWNA		INT				NOT NULL,
    FOREIGN KEY (ID_KLASY) REFERENCES KLASA (ID_KLASY),
	FOREIGN KEY (ID_SZKOLY) REFERENCES SZKOLA (ID_SZKOLY),
	FOREIGN KEY (ID_UZYTKOWNIKA) REFERENCES UZYTKOWNICY (ID_UZYTKOWNIKA),
	FOREIGN KEY (ID_DZIALU) REFERENCES DZIAL (ID_DZIALU),
	FOREIGN KEY (ID_PRZEDMIOTU) REFERENCES PRZEDMIOT (ID_PRZEDMIOTU),
	FOREIGN KEY (ID_POPRAWNA) REFERENCES ODPOWIEDZI (ID_ODP)
);

CREATE TABLE TEST
(
	ID_TESTU	    	INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    ID_PYTANIA 			INT		NOT NULL,
	ID_UZYTKOWNIKA		INT		NOT NULL,
	UDZIELONA       	INT		NOT NULL,
	DATA_TESTU			date	NOT NULL,
	DATA_WYPELNIENIA	INT		NOT NULL,
	UWAGI				VARCHAR2(60),
    FOREIGN KEY (ID_PYTANIA) REFERENCES PYTANIE (ID_PYTANIA),
	FOREIGN KEY (ID_UZYTKOWNIKA) REFERENCES UZYTKOWNICY (ID_UZYTKOWNIKA)
);

-- TABELE POMOCNICZE

CREATE TABLE UZYTKOWNICY_ARCHIVE
(
    ID_ARCHIVE         INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    USERNAME           VARCHAR2(30) NOT NULL,
    HASLO   	       VARCHAR2(30) NOT NULL,
    EMAIL              VARCHAR2(30) NOT NULL,
    IMIE	           VARCHAR2(30),
    NAZWISKO           VARCHAR2(30),
    TELEFON		 	   VARCHAR2(30) NOT NULL,
	ID_ROLI      	   INT          NOT NULL,
	ID_KLASY    	   INT          NOT NULL,
	ID_SZKOLY    	   INT          NOT NULL,
	DATA_AKCJI		   DATE,
	FOREIGN KEY (ID_ROLI) REFERENCES USER_ROLE (ID_ROLI),
    FOREIGN KEY (ID_KLASY) REFERENCES KLASA (ID_KLASY),
	FOREIGN KEY (ID_SZKOLY) REFERENCES SZKOLA (ID_SZKOLY)
);

CREATE TABLE LOGI
(
    ID_LOGU         	INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    OPERACJA  	    	VARCHAR2(30),
    DATA_OPERACJI   	DATE,
    TABELA			 	VARCHAR2(30)
);

-- WCZYTYWANIE DO BAZY PRZYK??ADOWYCH DANYCH

INSERT INTO USER_ROLE (ROLA)
VALUES ('ADMIN');
INSERT INTO USER_ROLE (ROLA)
VALUES ('NAUCZYCIEL');
INSERT INTO USER_ROLE (ROLA)
VALUES ('UCZEN');

INSERT INTO UZYTKOWNICY (USERNAME, HASLO, EMAIL, IMIE, NAZWISKO, TELEFON, ID_ROLI, ID_KLASY, ID_SZKOLY)
VALUES ('jakubk', 'jakubk', 'j.kowalewski@sp3.mlawa.pl', 'Jakub', 'Kowalewski', '+48-000-000-001', 1, 1, 1);
INSERT INTO UZYTKOWNICY (USERNAME, HASLO, EMAIL, IMIE, NAZWISKO, TELEFON, ID_ROLI, ID_KLASY, ID_SZKOLY)
VALUES ('jakubk', 'jakubk', 'j.kowalewski@sp3.mlawa.pl', 'Jakub', 'Kowalewski', '+48-000-000-001', 2, 1, 1);
INSERT INTO UZYTKOWNICY (USERNAME, HASLO, EMAIL, IMIE, NAZWISKO, TELEFON, ID_ROLI, ID_KLASY, ID_SZKOLY)
VALUES ('jank', 'jank', 'j.kowalski@sp3.mlawa.pl', 'Jan', 'Kowalski', '+48-000-000-002', 3, 1, 2);

INSERT INTO UPRAWNIENIA (ID_ROLI, ID_UZYTKOWNIKA)
VALUES (1, 1);
INSERT INTO UPRAWNIENIA (ID_ROLI, ID_UZYTKOWNIKA)
VALUES (2, 2);
INSERT INTO UPRAWNIENIA (ID_ROLI, ID_UZYTKOWNIKA)
VALUES (3, 3);

INSERT INTO SZKOLA (NAZWA, OPIS)
VALUES ('SP', 'Szko??a Podstawowa');
INSERT INTO SZKOLA (NAZWA, OPIS)
VALUES ('LO', 'Liceum Og??lnokszta??c??ce');
INSERT INTO SZKOLA (NAZWA, OPIS)
VALUES ('TECH', 'Technikum');
INSERT INTO SZKOLA (NAZWA, OPIS)
VALUES ('SB', 'Szko??a Bran??owa');

INSERT INTO KLASA (NAZWA, ID_SZKOLY)
VALUES (1, 1);
INSERT INTO KLASA (NAZWA, ID_SZKOLY)
VALUES (1, 2);
INSERT INTO KLASA (NAZWA, ID_SZKOLY)
VALUES (1, 3);
INSERT INTO KLASA (NAZWA, ID_SZKOLY)
VALUES (2, 1);

INSERT INTO PRZEDMIOT (NAZWA, ID_KLASY, ID_SZKOLY)
VALUES ('Informatyka',1, 1);
INSERT INTO PRZEDMIOT (NAZWA, ID_KLASY, ID_SZKOLY)
VALUES ('Technika',1, 1);
INSERT INTO PRZEDMIOT (NAZWA, ID_KLASY, ID_SZKOLY)
VALUES ('Historia',1, 1);

INSERT INTO DZIAL (NAZWA, ID_PRZEDMIOTU)
VALUES ('Kodowanie',1);
INSERT INTO DZIAL (NAZWA, ID_PRZEDMIOTU)
VALUES ('Internet',1);
INSERT INTO DZIAL (NAZWA, ID_PRZEDMIOTU)
VALUES ('WORD',1);

INSERT INTO PYTANIE (ID_KLASY, ID_SZKOLY, ID_UZYTKOWNIKA, TRESC, ID_DZIALU, ID_PRZEDMIOTU, ID_POPRAWNA)
VALUES (1, 1, 2, 'Co to jest p??tla',1, 1, 1);
INSERT INTO PYTANIE (ID_KLASY, ID_SZKOLY, ID_UZYTKOWNIKA, TRESC, ID_DZIALU, ID_PRZEDMIOTU, ID_POPRAWNA)
VALUES (1, 1, 2, 'Co to jest kodowanie',1, 1, 1);
INSERT INTO PYTANIE (ID_KLASY, ID_SZKOLY, ID_UZYTKOWNIKA, TRESC, ID_DZIALU, ID_PRZEDMIOTU, ID_POPRAWNA)
VALUES (1, 1, 2, 'Co to jest Internet',2, 1, 1);

INSERT INTO ODPOWIEDZI (NAZWA)
VALUES ('TAK');
INSERT INTO ODPOWIEDZI (NAZWA)
VALUES ('NIE');
INSERT INTO ODPOWIEDZI (NAZWA)
VALUES ('ZADNA');

INSERT INTO TEST (ID_PYTANIA, ID_UZYTKOWNIKA, UDZIELONA, DATA_TESTU, DATA_WYPELNIENIA, UWAGI)
VALUES (1, 3, 'TAK', '19-06-2021', '22-06-2021', 'BRAK');
INSERT INTO TEST (ID_PYTANIA, ID_UZYTKOWNIKA, UDZIELONA, DATA_TESTU, DATA_WYPELNIENIA, UWAGI)
VALUES (2, 3, 'NIE', '19-06-2021', '22-06-2021', 'BRAK');
INSERT INTO TEST (ID_PYTANIA, ID_UZYTKOWNIKA, UDZIELONA, DATA_TESTU, DATA_WYPELNIENIA, UWAGI)
VALUES (3, 3, 'TAK', '19-06-2021', '22-06-2021', 'BRAK');


-- PROCEDURY, FUNKCJE, WYZWALACZE OBSLUGUJACE BAZE

-- DODAWANIE REKORDOW

CREATE OR REPLACE PROCEDURE dodaj_uzytkownika
(	V_USERNAME 		VARCHAR2,
	V_HASLO 		VARCHAR2,
    V_EMAIL 		VARCHAR2,
    V_IMIE 			VARCHAR2 DEFAULT '',
    V_NAZWISKO 		VARCHAR2 DEFAULT '',
    V_TELEFON 		VARCHAR2 DEFAULT '',
    V_ID_ROLI 		INT DEFAULT NULL,
	V_ID_KLASY 		INT DEFAULT NULL,
	V_ID_SZKOLY 	INT DEFAULT NULL
)
IS
BEGIN
    INSERT INTO UZYTKOWNICY (USERNAME, HASLO, EMAIL, IMIE, NAZWISKO, TELEFON, ID_ROLI, ID_KLASY, ID_SZKOLY)
    VALUES (V_USERNAME, V_HASLO, V_EMAIL, V_IMIE, V_NAZWISKO, V_TELEFON, V_ID_ROLI, V_ID_KLASY, V_ID_SZKOLY);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Poda??es z??e dane');
        DBMS_OUTPUT.PUT_LINE('Kod b??edu: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Komunikat: ' || SQLERRM);
END;

-- AKTUALIZACJA REKORDOW

CREATE OR REPLACE PROCEDURE ZMIEN_HASLO 
(
	V_ID_UZYTKOWNIKA 	INT,
    V_NEW_HASLO 		VARCHAR2
)
IS
BEGIN
    UPDATE UZYTKOWNICY SET HASLO = V_NEW_HASLO WHERE ID_UZYTKOWNIKA = V_ID_UZYTKOWNIKA;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nie zaktualizowano ??adnych danych');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Poda??es z??e dane');
         DBMS_OUTPUT.PUT_LINE('Kod b??edu: ' || SQLCODE);
         DBMS_OUTPUT.PUT_LINE('Komunikat: ' || SQLERRM);
END;

-- USUWANIE REKORDOW

CREATE OR REPLACE PROCEDURE USUN_UZYTKOWNIKA
(
	V_ID_UZYTKOWNIKA INT)
    IS
    NO_ROWS_DELETED EXCEPTION;
    PRAGMA EXCEPTION_INIT (NO_ROWS_DELETED, -2001
);
BEGIN
    DELETE FROM UZYTKOWNICY WHERE ID_UZYTKOWNIKA = V_ID_UZYTKOWNIKA;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nie usunieto ??adnych danych');
    END IF;
EXCEPTION
    WHEN NO_ROWS_DELETED THEN
		 DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Poda??es z??e dane');
         DBMS_OUTPUT.PUT_LINE('Kod b??edu: ' || SQLCODE);
         DBMS_OUTPUT.PUT_LINE('Komunikat: ' || SQLERRM);
END;

-- ARCHIWIZACJA USUNIETYCH DANYCH


CREATE OR REPLACE TRIGGER UZYTKOWNICY_ARCHIWIZACJA
    BEFORE DELETE
    ON UZYTKOWNICY
    FOR EACH ROW
BEGIN
    INSERT INTO UZYTKOWNICY_ARCHIVE (USERNAME, HASLO, EMAIL, IMIE, NAZWISKO, TELEFON, ID_ROLI, ID_KLASY, ID_SZKOLY,
    DATA_AKCJI)
    VALUES (:OLD.USERNAME, :OLD.HASLO, :OLD.EMAIL, :OLD.IMIE, :OLD.NAZWISKO, :OLD.TELEFON, :OLD.ID_ROLI,
    :OLD.ID_KLASY, :OLD.ID_SZKOLY, CURRENT_DATE);
END;

-- LOGOWANIE INFORMACJI DO TABELI

CREATE OR REPLACE TRIGGER LOGI_USUWANIE_UZYTKOWNIKA
    AFTER DELETE
    ON UZYTKOWNICY
BEGIN
    INSERT INTO LOGI (OPERACJA, DATA_OPERACJI, TABELA)
    VALUES ('USUNIECIE', CURRENT_DATE, 'UZYTKOWNICY');
END;

CREATE OR REPLACE TRIGGER LOGI_DODANIE_UZYTKOWNIKA
    AFTER INSERT
    ON UZYTKOWNICY
BEGIN
    INSERT INTO LOGI (OPERACJA, DATA_OPERACJI, TABELA)
    VALUES ('DODANIE', CURRENT_DATE, 'UZYTKOWNICY');
END;

CREATE OR REPLACE TRIGGER LOGI_AKTUALIZACJA_UZYTKOWNIKA
    AFTER UPDATE
    ON UZYTKOWNICY
BEGIN
    INSERT INTO LOGS (OPERACJA, DATA_OPERACJI, TABELA)
    VALUES ('AKTUALIZACJA', CURRENT_DATE, 'UZYTKOWNICY');
END;

-- FUNKCJA SPRAWDZAJACE POPRAWNOSC E-MAILA

CREATE OR REPLACE FUNCTION SPRAWDZ_EMAIL (V_EMAIL VARCHAR2) RETURN BOOLEAN IS
BEGIN
    IF V_EMAIL NOT LIKE '_%@__%.__%' THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;