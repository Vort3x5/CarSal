# Transformacja do Modelu Relacyjnego

Proces konwersji z modelu konceptualnego do logicznego wymagał usunięcia następujących właściwości niekompatybilnych z modelem relacyjnym:

## 1. Rozbicie atrybutów złożonych (Composite)

Atrybuty złożone zostały "spłaszczone" do postaci pojedynczych kolumn w odpowiednich tabelach.

* **Encja `SALON`:**
    * `adres` (composite) $\rightarrow$ `ulica`, `miasto`, `kod_pocztowy` w tabeli `SALONY`.
* **Encja `KLIENT`:**
    * `adres` (composite) $\rightarrow$ `ulica`, `miasto`, `kod_pocztowy` w tabeli `KLIENTCI`.
    * `dane_osobowe` (composite) $\rightarrow$ `imie`, `nazwisko`, `pesel` w tabeli `KLIENTCI`.
    * `dane_firmowe` (composite) $\rightarrow$ `nazwa_firmy`, `nip` w tabeli `KLIENTCI`.

## 2. Rozbicie atrybutów wielowartościowych (Multivalued)

Atrybuty wielowartościowe są przenoszone do oddzielnych tabel (relacji) powiązanych kluczem obcym.

* **Encja `SERWISANT`:**
    * `certyfikaty` (multivalued) $\rightarrow$ Nowa tabela `CERTYFIKATY_SERWISANTA` z kolumnami `(nr_pracownika, certyfikat)`, gdzie `nr_pracownika` jest kluczem obcym do tabeli `SERWISANCI`.

## 3. Rozbicie związków M:N

Związki typu M:N są implementowane za pomocą tabel łączących (asocjacyjnych).

* **Związek `POJAZD [ma_wyposazenie] WYPOSAZENIE` (M:N)**
    * $\rightarrow$ Nowa tabela `POJAZDY_WYPOSAZENIE` z kluczem złożonym `(nr_vin, id_wyposazenia)`, gdzie obie kolumny są kluczami obcymi wskazującymi odpowiednio na `POJAZDY` i `WYPOSAZENIE`.
* **Związek `KLIENT [rezerwuje] POJAZD` (M:N przez `TEST_DRIVE`)**
    * $\rightarrow$ Tabela `JAZDY_TESTOWE` (w modelu konceptualnym `TEST_DRIVE`) pełni rolę tabeli łączącej z kluczem złożonym `(nr_klienta, nr_vin, data_jazdy)` oraz dodatkowymi atrybutami (np. `status`, `nr_prawa_jazdy`).

## 4. Implementacja hierarchii specjalizacji (ISA)

Hierarchia `PRACOWNIK [ISA] {SPRZEDAWCA, SERWISANT}` (Overlapping, Partial) została zaimplementowana zgodnie z zaleceniami przy użyciu N tabel:

1.  **`PRACOWNICY`**: Tabela nadrzędna zawierająca atrybuty wspólne.
2.  **`SPRZEDAWCY`**: Tabela specjalizacji zawierająca atrybuty specyficzne dla sprzedawcy.
3.  **`SERWISANCI`**: Tabela specjalizacji zawierająca atrybuty specyficzne dla serwisanta.

* Relacje `SPRZEDAWCY` i `SERWISANCI` są połączone z `PRACOWNICY` związkiem 1:1.
* Klucz główny `nr_pracownika` z tabeli `PRACOWNICY` jest jednocześnie kluczem głównym i obcym (PK/FK) w tabelach `SPRZEDAWCY` i `SERWISANCI`.
