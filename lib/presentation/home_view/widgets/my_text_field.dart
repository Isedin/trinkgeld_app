import 'package:flutter/material.dart';

/// Widget MyTextfield ist ein benutzerdefiniertes Textfeld, das eine einfache Umhüllung für das Flutter-TextField bietet.
class MyTextfield extends StatelessWidget {
  /// Das Label für das Textfeld.
  final String labelText;

  /// Der Typ der Texteingabe (optional).
  final TextInputType? textInputType;

  /// Callback-Funktion, die aufgerufen wird, wenn sich der Text ändert (optional).
  final void Function(String)? onChanged;

  final InputDecoration decoration;

  /// Konstruktor für die Initialisierung der erforderlichen Felder und optionalen Parameter.
  const MyTextfield({
    required this.labelText,
    required this.decoration,
    super.key,
    this.textInputType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          keyboardType: textInputType,
          onChanged: onChanged,
          decoration: decoration.copyWith(labelText: labelText),
        ),
      );
}
