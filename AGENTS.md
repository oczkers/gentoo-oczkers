# Gentoo Overlay Guidelines for AI Agents

Instrukcje dotyczące tworzenia i aktualizowania ebuildów w nakładce `oczkers`.

## 1. Tworzenie / Aktualizacja ebuilda

1. **Weryfikacja upstreamu**:
   - Sprawdź najnowszą wersję, licencję i zależności (np. PyPI JSON API, GitHub releases/tags, `pyproject.toml`, `Cargo.toml`).
2. **Struktura katalogu**:
   - Pliki umieszczaj w `kategoria/nazwa-pakietu/`.
   - Wymagane pliki: `<nazwa>-<wersja>.ebuild`, `metadata.xml`, `Manifest`.
3. **Konwencje ebuilda (EAPI 8)**:
   - Nagłówek:
     ```bash
     # Copyright 2026 Gentoo Authors
     # Distributed under the terms of the GNU General Public License v2
     ```
   - Standardowe słowa kluczowe dla nowych pakietów: `KEYWORDS="~amd64 ~arm64 ~x86"`.
   - Dla pakietów Pythonowych (`distutils-r1`):
     - Zdefiniuj `DISTUTILS_USE_PEP517` (`hatchling`, `setuptools`, `flit_core`, `poetry-core` itp.).
     - Zdefiniuj `PYTHON_COMPAT=( python3_{11..14} )` zgodnie z obsługą upstreamu.
     - Użyj `distutils_enable_tests pytest` lub odpowiedniej funkcji, jeśli testy są wspierane.
4. **`metadata.xml`**:
   - Domyślny maintainer: `Piotr Staroszczyk <piotr.staroszczyk@get24.org>`.
   - W sekcji `<upstream>` dodaj odpowiednie identyfikatory (`pypi`, `github`, `gitlab` itp.).

## 2. Kluczowe komendy Portage

```bash
# Wygenerowanie / aktualizacja Manifestu (pobiera distfiles i oblicza sumy kontrolne):
ebuild <ścieżka-do-ebuilda> manifest

# Testowa kompilacja:
ebuild <ścieżka-do-ebuilda> compile

# Czyszczenie katalogu roboczego po testach:
ebuild <ścieżka-do-ebuilda> clean
```

## 3. Konwencja commitów Git

- Format: `<kategoria>/<pakiet>: <opis>` (np. `dev-python/pytest-gremlins: add 1.9.0` lub `dev-python/foo: bump to 1.2.0`).
- Nowe pliki dokumentacji/meta: `<plik>: <opis>` (np. `AGENTS.md: add overlay guide for AI agents`).
