# Bewertung

## Dateistruktur

Prinzipiell finde ich die Struktur gut. Dein Projekt ist natürlich eines der kleineren und das hilft dabei, das sauber zu gestalten, aber da findet man sich gleich zurecht und das ist gut.

## Umsetzung

### pubspec.yaml

Du hattest nicht viele Lints aktiviert. Ich hab das mal geändert und bin sofort von 11 Problemen auf über 200 hoch.

### main.dart

Natürlich zu viel Grün für meinen Geschmack, aber solang das unter dem eigentlichen Code passiert, ist das ok.

Die Zeile `WidgetRef? globalRef;` glaube ich eigentlich nicht, dass Du sie brauchst. Es klingt verlockend, von überall auf ref zugreifen zu können, aber ich glaube eigentlich das geht sowieso. Ich hab sie einfach mal gelöscht und wollte es überall dort fixen, wo es deswegen zu Problemen kam. Hab es getan und - nirgendwo rot, also brauchte man das nirgendwo. :-)

Die globalLanguageLibrary nutzt Du ausschließlich in den Settings. Ich tendiere dazu, das dann auch nur dort lokal zu nutzen. Hab das entsprechend verschoben. Es wäre ein bisschen (unerhebliche) Platzverschwendung, hier global immer zwei Objekte (die theoretisch ja groß werden könnten) im Speicher zu behalten, wenn man sie nur braucht, um zwei Buttons auf dem Settings-Screen zu zeichnen.

Der Einsatz von Theming und DarkMode ist super. Wenig und elegant.

### appstate_provider.dart

```dart
  // ignore: body_might_complete_normally_nullable
  Country? getCountryById(String id) {
    for (final country in state.countries) {
      if (country.id == id) {
        return country;
      }
    }
  }
```

Mir gefällt nicht, wenn Du bestimmte Hilfestellungen des Compilers / Linters ausschaltest durch die ignore-Anweisung, ohne Dich wirklich mit ihnen auseinander zu setzen. Warum kommen sie und was heißen sie? Manchmal kann man nicht anders als so eine Meldung zu ignorieren, aber hier .. nicht wirklich. So sieht der Fix aus:

```dart
  Country? getCountryById(String id) {
    for (final country in state.countries) {
      if (country.id == id) {
        return country;
      }
    }
    return null;
  }
```

Es ging nur darum, dass die Funktion unter bestimmten Umständen (hier: Country nicht gefunden) durchlaufen kann, ohne mit einem explizieten return-Statement abzuschließen. Das ist dann ein echtes Problem (roter Fehler), wenn es einen nicht-nullable Rückgabewert gibt. Es ist nur eine Warnung (blau), wenn der Rückgabewert nullable ist, denn eine durchlaufende Funktion ohne Rückgabewert gibt automatisch null zurück, aber es ist besserer Stil, das auch kenntlich zu machen.

Ich hab an einigen, wenigen Stellen Deinen (richtigen!) Implementationen noch eine eigene folgen lassen, wie beispielsweise dieser:

```dart
  void changeOwnTippProfile({
    required Country country,
    required int min,
    required int mid,
    required int high,
  }) {
    // Country toEditCountry = state.countries[int.parse(country.id)];
    final changedCountry = country.copyWith(percentageLow: min, percentageMid: mid, percentageHigh: high);
    List<Country> newCountryList = [];
    for (Country c in state.countries) {
      if (c.id == country.id) {
        newCountryList.add(changedCountry);
      } else {
        newCountryList.add(c);
      }
    }
    //  [changedCountry, ...countryList];
    final newState = state.copyWith(
      countries: newCountryList,
      selectedCountry: changedCountry.id,
    );
    state = newState;
  }
```
Hier kann man die Erstellung der `newCountryList` erheblich kürzer darstellen. Das ist aber keine Kritik, denn mir ist es 100mal lieber, Du machst Deine Lösung und verstehst sie (und die log-Zeilen und so sind gute Indikatoren dafür), als du setzt auf irgendeinen Code, den Du nicht verstehst. :-)

```dart
  void changeOwnTippProfile2({
    required Country country,
    required int min,
    required int mid,
    required int high,
  }) {
    // Country toEditCountry = state.countries[int.parse(country.id)];
    final changedCountry = country.copyWith(percentageLow: min, percentageMid: mid, percentageHigh: high);
    final newCountryList = state.countries.map((e) => e.id == country.id ? changedCountry : e).toList();
    final newState = state.copyWith(
      countries: newCountryList,
      selectedCountry: changedCountry.id,
    );
    state = newState;
  }
```



### Alle Datenklassen

Ich hab die Attribute jeweils auf final umgestellt. Dadurch konnte ich die Constructors mit const definieren und das wiederum führt dazu, dass zum Beispiel der Ausgangszustand vom AppStateProvider jetzt eine Konstante ist, was (natürlich nicht messbar) die Performance erhöht. Generell gilt: Unsere Arten von Datenklassen haben eigentlich immer finale Attribute, denn sie ändern sich ja nicht, sondern werden im Zweifelsfall durch was Neues ersetzt.