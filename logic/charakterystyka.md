# Model Logiczny - Charakterystyka

Model logiczny stanowi transformację modelu konceptualnego na model relacyjny, który jest bezpośrednio implementowalny w relacyjnym systemie zarządzania bazą danych (SZBD), takim jak Oracle.

Kluczowe cechy modelu logicznego dla projektu Salonu Samochodowego:

1.  **Struktura oparta na relacjach (tabelach):** Wszystkie encje i związki z modelu konceptualnego zostają przełożone na relacje (tabele).
2.  **Nazewnictwo:** Zgodnie z wytycznymi, nazwy encji z liczby pojedynczej (np. `POJAZD`) zostały zmienione na liczbę mnogą (np. `POJAZDY`). Polskie znaki nie są używane w nazwach obiektów bazy danych (tabel, kolumn).
3.  **Klucze obce (Foreign Keys):** Związki (relacje) między encjami są implementowane za pomocą kluczy obcych, które zapewniają integralność referencyjną.
4.  **Normalizacja:** Model jest znormalizowany, co najmniej do trzeciej postaci normalnej (3NF), aby wyeliminować redundancję danych i anomalie.
5.  **Brak struktur niekompatybilnych:** Usunięto wszystkie cechy modelu konceptualnego, które nie są bezpośrednio wspierane przez model relacyjny, takie jak atrybuty złożone, atrybuty wielowartościowe oraz związki M:N.
