enum Quality {
  low,
  mid,
  high,
}

extension QualityExtension on Quality {
  int get stars {
    if (this == Quality.low) {
      return 1;
    } else if (this == Quality.mid) {
      return 2;
    }
    return 3;
  }

  static Quality fromStars(int stars) {
    if (stars == 1) {
      return Quality.low;
    } else if (stars == 2) {
      return Quality.mid;
    }
    return Quality.high;
  }
}

// Dieser Teil des Codes definiert ein Enum namens "Quality" mit den Werten "low", "mid" und "high".

// Es wird auch eine Erweiterung (Extension) für das Enum definiert, die eine Methode namens "stars" enthält. Diese Methode gibt je nach Wert des Enums eine entsprechende Anzahl von Sternen zurück. Wenn der Wert "low" ist, wird 1 zurückgegeben, wenn der Wert "mid" ist, wird 2 zurückgegeben, andernfalls wird 3 zurückgegeben.

// Es wird auch eine statische Methode namens "fromStars" definiert, die einen Integer-Wert entgegennimmt und basierend auf diesem Wert den entsprechenden Quality-Wert zurückgibt. Wenn der Wert 1 ist, wird "low" zurückgegeben, wenn der Wert 2 ist, wird "mid" zurückgegeben, andernfalls wird "high" zurückgegeben.

// Zusammenfassend erweitert dieser Code das Enum "Quality" um zwei nützliche Methoden: Eine Methode zur Umwandlung des Enums in eine Anzahl von Sternen und eine Methode zur Umwandlung einer Anzahl von Sternen in den entsprechenden Quality-Wert.
