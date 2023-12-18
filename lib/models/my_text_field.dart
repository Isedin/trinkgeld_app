import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

class MyTextfield extends StatelessWidget {
  final String labelText;
  final TextInputType? textInputType;
  final void Function(String)? onChanged;

  const MyTextfield({
    required this.labelText, required InputDecoration decoration, super.key,
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
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Color.fromARGB(255, 170, 29, 29))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: labelText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
}

// Der oben gegebene Code definiert eine Klasse namens "MyTextfield", die von der Klasse "StatelessWidget" erbt. Diese Klasse stellt ein benutzerdefiniertes Textfeld-Widget dar.

// Die Klasse hat folgende Eigenschaften:

// Ein Objekt vom Typ "TextEditingController" mit dem Namen "controller". Dieses Objekt wird verwendet, um den Text im Textfeld zu steuern.
// Eine Zeichenkette mit dem Namen "labelText", die den Beschriftungstext für das Textfeld enthält.
// Ein optionales Objekt vom Typ "TextInputType" mit dem Namen "textInputType". Dieses Objekt gibt den Typ der Tastatur an, die angezeigt werden soll. Es ist optional und kann weggelassen werden.
// Die Klasse hat einen Konstruktor, der die oben genannten Eigenschaften als erforderliche Parameter annimmt. Der Konstruktor erbt auch den optionalen Parameter "key" von der übergeordneten Klasse "StatelessWidget".

// Die Methode "build" überschreibt die entsprechende Methode der übergeordneten Klasse. Sie erstellt ein Padding-Widget mit einem horizontalen Abstand von 25 Einheiten und enthält ein TextField-Widget. Das TextField-Widget verwendet den übergebenen "textInputType", den übergebenen "controller" und eine benutzerdefinierte Dekoration für das Erscheinungsbild des Textfelds.

// Insgesamt ermöglicht dieser Code das Erstellen eines benutzerdefinierten Textfeld-Widgets mit verschiedenen Eigenschaften wie Controller, Beschriftungstext und Tastaturtyp.
