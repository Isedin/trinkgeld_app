import 'package:intl/intl.dart';

String safeLocale(String desired, {String fallback = 'en_US'}) {
  try {
    // Pokušaj inicijalizirati bilo koji formatter s traženim locale-om.
    // Ako baci, locale nije podržan.
    NumberFormat('', desired);
    return desired;
  } catch (_) {
    return fallback;
  }
}
