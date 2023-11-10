enum Emoji {
  low,
  mid,
  high,
}

extension EmojiExtension on Emoji {
  int get emoji {
    if (this == Emoji.low) {
      return 1;
    } else if (this == Emoji.mid) {
      return 2;
    }
    return 3;
  }

  static Emoji fromStars(int stars) {
    if (stars == 1) {
      return Emoji.low;
    } else if (stars == 2) {
      return Emoji.mid;
    }
    return Emoji.high;
  }
}
