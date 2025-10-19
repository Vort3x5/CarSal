# Proces Normalizacji

Model logiczny został zaprojektowany z uwzględnieniem zasad normalizacji, aby zapewnić co najmniej Trzecią Postać Normalną (3NF). Celem jest eliminacja redundancji danych i uniknięcie anomalii (aktualizacji, wstawiania, usuwania).

## 1. Pierwsza Postać Normalna (1NF)

* **Zasada:** Każdy atrybut (kolumna) musi zawierać wartości atomowe (niepodzielne).
* **Zastosowanie:**
    * Rozbicie atrybutów złożonych (np. `adres` na `ulica`, `miasto`, `kod_pocztowy`) zapewniło atomowość.
    * Przeniesienie atrybutów wielowartościowych (np. `certyfikaty` serwisanta) do oddzielnej tabeli `CERTYFIKATY_SERWISANTA` zapewniło 1NF.

## 2. Druga Postać Normalna (2NF)

* **Zasada:** Tabela musi być w 1NF, a wszystkie atrybuty niekluczowe muszą być w pełni funkcyjnie zależne od całego klucza głównego (dotyczy kluczy złożonych).
* **Zastosowanie:**
    * **Tabela `JAZDY_TESTOWE`:** Klucz główny to `(nr_klienta, nr_vin, data_jazdy)`. Atrybuty takie jak `nr_prawa_jazdy` czy `status` zależą od całej kombinacji (konkretny klient, konkretny pojazd i konkretny termin), a nie tylko od części klucza (np. samego klienta lub samego pojazdu).
    * **Tabela `POJAZDY_WYPOSAZENIE`:** Klucz główny to `(nr_vin, id_wyposazenia)`. Tabela ta nie posiada dodatkowych atrybutów niekluczowych, więc trywialnie spełnia 2NF.

## 3. Trzecia Postać Normalna (3NF)

* **Zasada:** Tabela musi być w 2NF, a wszystkie atrybuty niekluczowe nie mogą zależeć przechodnio od klucza głównego (tzn. żaden atrybut niekluczowy nie może zależeć od innego atrybutu niekluczowego).
* **Zastosowanie:**
    * **Tabela `POJAZDY`:** Klucz główny to `nr_vin`. Atrybuty `id_modelu` i `nr_salonu` są kluczami obcymi.
    * **Problem:** W modelu konceptualnym `MODEL_SAMOCHODU` zawierał informacje o producencie (np. `nazwa_producenta`).
    * **Rozwiązanie:** Wyprowadzono encję `PRODUCENT` i połączono ją z `MODEL_SAMOCHODU` kluczem obcym. W tabeli `MODELE_SAMOCHODOW` (klucz `id_modelu`) znajduje się `id_producenta`, a nie `nazwa_producenta`. Zapobiega to zależności przechodniej: `POJAZD.nr_vin -> MODEL.id_modelu -> PRODUCENT.id_producenta`.
    * **Tabela `SPRZEDAZ`:** Klucz główny to `nr_sprzedazy`. Zawiera klucze obce `nr_klienta`, `nr_pracownika`, `nr_vin`. Dane klienta, pracownika i pojazdu znajdują się w oddzielnych tabelach, co eliminuje zależności przechodnie.
