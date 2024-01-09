/// Enum-Definition für Emoji mit den Werten low, mid und high.
enum Emoji {
  ///niedrig
  low,

  ///mitte
  mid,

  ///hoch
  high,
}

/// Extension-Methode für das Enum Emoji.
extension EmojiExtension on Emoji {
  /// Getter-Methode, die je nach Wert des Enums eine Emoji-Zahl zurückgibt.
  int get emoji {
    if (this == Emoji.low) {
      return 1;
    } else if (this == Emoji.mid) {
      return 2;
    }
    return 3;
  }

  /// Statische Methode zum Erstellen eines Emoji-Enums basierend auf einer Sternebewertung.
  static Emoji fromStars(int stars) {
    if (stars == 1) {
      return Emoji.low;
    } else if (stars == 2) {
      return Emoji.mid;
    }
    return Emoji.high;
  }
}
