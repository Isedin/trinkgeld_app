import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

/// Die Klasse EmailValidation ist ein StatefulWidget für die Eingabe und Validierung von E-Mail-Adressen.
class EmailValidation extends ConsumerStatefulWidget {
  /// Ein Fokusnode für dieses Widget.
  final FocusNode thisNode = FocusNode();

  /// Ein Fokusnode für das nächste Widget, das den Fokus erhalten soll.
  final FocusNode nextNode;

  /// Konstruktor für die Initialisierung von Instanzvariablen.
  EmailValidation({required this.nextNode, super.key});

  /// Überschreibt die createState-Methode, um eine Instanz des assoziierten State zurückzugeben.
  @override
  EmailValidationState createState() => EmailValidationState();
}

/// Der State für das EmailValidation-Widget.
class EmailValidationState extends ConsumerState<EmailValidation> {
  //  List<TextEditingController> controllers;
  // List<FocusNode> focusNodes;
  /// Ein Controller für die Eingabe der E-Mail-Adresse.
  TextEditingController emailController = TextEditingController();

  /// Methode zur Validierung der eingegebenen E-Mail-Adresse.
  void validateEmail() {
    final isValid = EmailValidator.validate(emailController.text.trim());

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valid Email')));
      widget.nextNode.requestFocus();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not a Valid Email')));
      widget.thisNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;

    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: TextFormField(
              onFieldSubmitted: (value) => validateEmail(),
              controller: emailController,
              focusNode: widget.thisNode,
              decoration: InputDecoration(
                labelText: translate.eMailValidationFieldText,
                border: settingsButtonsBorder,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
