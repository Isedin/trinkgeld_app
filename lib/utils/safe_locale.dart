import 'package:intl/intl.dart';

String safeLocale(String desired, {String fallback = 'en_US'}) {
  try {
    // try to initialize any formatter with the desired locale.
    // if it doesn't throw, we can use it safely
    NumberFormat('', desired);
    return desired;
  } catch (_) {
    return fallback;
  }
}
