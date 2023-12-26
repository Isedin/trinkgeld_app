import 'package:trinkgeld_app/models/quality.dart';

/// Die Klasse TippOverride repräsentiert eine Konfiguration für individuelle Trinkgeldraten.
class TippOverride {
  /// Eindeutige Kennung für die Tipp-Überschreibung.
  final String id;

  /// Die Qualität, für die die Trinkgeld-Überschreibung gilt (eine enum-Qualität).
  final Quality quality;

  /// Der prozentuale Trinkgeldsatz für die angegebene Qualität.
  final int percentage;

  /// Konstruktor für die Initialisierung der Instanzvariablen.
  const TippOverride({
    required this.id,
    required this.quality,
    required this.percentage,
  });
}
