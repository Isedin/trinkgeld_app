import 'package:flutter/material.dart';

/// Widget MyTextfield ist ein benutzerdefiniertes Textfeld, das eine einfache Umhüllung für das Flutter-TextField bietet.
class MyTextfield extends StatelessWidget {
  /// Das Label für das Textfeld.
  final String labelText;

  /// Der Typ der Texteingabe (optional).
  final TextInputType? textInputType;

  /// Callback-Funktion, die aufgerufen wird, wenn sich der Text ändert (optional).
  final void Function(String)? onChanged;

  /// Konstruktor für die Initialisierung der erforderlichen Felder und optionalen Parameter.
  const MyTextfield({
    required this.labelText,
    required InputDecoration decoration,
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
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.euro),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30),
                ),
                borderSide: BorderSide(color: Color.fromARGB(255, 170, 29, 29))),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: const Color.fromARGB(255, 193, 209, 174),
            filled: true,
            labelText: labelText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
      );
}
