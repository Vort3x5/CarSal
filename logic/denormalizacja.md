# Proces Denormalizacji

## Przykład 1: Denormalizacja na potrzeby raportów sprzedaży (Rozważane)

* **Problem:** Częste zapytania menedżerów salonu o łączną wartość sprzedaży dla danego sprzedawcy lub salonu. W modelu znormalizowanym (3NF) wymaga to łączenia tabel `SPRZEDAZ`, `PRACOWNICY` i `SALONY` oraz użycia funkcji agregujących (`SUM`).
* **Potencjalne rozwiązanie (Denormalizacja):**
    * Dodanie kolumny `liczba_sprzedazy` lub `laczna_wartosc_sprzedazy` do tabeli `SPRZEDAWCY` (co zostało już uwzględnione w modelu konceptualnym jako `liczba_sprzedazy`).
    * Dodanie kolumny `laczna_wartosc_sprzedazy_miesiac` do tabeli `SALONY`.
* **Wady:**
    * Wymaga to implementacji triggerów, które po każdej zakończonej transakcji w tabeli `SPRZEDAZ` aktualizowałyby te zagregowane wartości w tabelach `SPRZEDAWCY` i `SALONY`.
    * Powoduje to redundancję (dane są przechowywane w dwóch miejscach) i zwiększa narzut przy operacjach `INSERT` na tabeli `SPRZEDAZ`.
* **Decyzja:** Na obecnym etapie projektu, przy założeniu, że raporty nie są generowane w czasie rzeczywistym co sekundę, wydajność modelu 3NF jest wystarczająca. Agregacja danych może być realizowana przez widoki (perspektywy) lub widoki zmaterializowane, które są preferowaną metodą optymalizacji w takich przypadkach, zanim podejmie się decyzję o modyfikacji struktury tabel.

## Przykład 2: Przechowywanie nazwy modelu w tabeli `POJAZDY` (Odrzucone)

* **Problem:** Aby wyświetlić listę dostępnych pojazdów wraz z ich nazwami modeli, wymagane jest złączenie tabel `POJAZDY` i `MODELE_SAMOCHODOW`.
* **Potencjalne rozwiązanie (Denormalizacja):** Dodanie kolumny `nazwa_modelu` do tabeli `POJAZDY`.
* **Wady:**
    * Drastyczne naruszenie 3NF (zależność przechodnia `nr_vin -> id_modelu -> nazwa_modelu`).
    * Anomalia aktualizacji: Jeśli nazwa modelu ulegnie zmianie (np. rebranding), trzeba ją zaktualizować we wszystkich rekordach w tabeli `POJAZDY` dla tego modelu, zamiast w jednym miejscu w tabeli `MODELE_SAMOCHODOW`.
* **Decyzja:** Rozwiązanie kategorycznie odrzucone. Koszty utrzymania spójności danych znacznie przewyższają minimalny zysk wydajnościowy (łączenie po indeksowanym kluczu obcym jest szybkie).

**Wniosek:** Na etapie projektowania logicznego model pozostaje w pełnej 3NF. Optymalizacja wydajności zapytań raportowych będzie realizowana w fazie fizycznej za pomocą indeksów oraz potencjalnie widoków zmaterializowanych, a nie przez denormalizację struktury tabel.
