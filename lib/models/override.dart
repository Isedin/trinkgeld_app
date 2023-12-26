import 'package:trinkgeld_app/models/quality.dart';

class TippOverride {
  final String id;
  final Quality quality;
  final int percentage;

  const TippOverride({
    required this.id,
    required this.quality,
    required this.percentage,
  });
}
