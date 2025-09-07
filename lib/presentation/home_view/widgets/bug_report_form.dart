import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:trinkgeld_app/presentation/home_view/widgets/email_validation.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

/// Die Klasse BugReportForm erweitert ConsumerWidget, was darauf hinweist, dass es sich um einen Widget handelt, der auf Änderungen reagieren kann.
class BugReportForm extends ConsumerStatefulWidget {
  /// FocusNode für das Eingabefeld "describeTheBug".
  final describeTheBugNode = FocusNode();

  ///Überprüft den Text der im Feld Bug Report eingegeben wird
  final bugTextController = TextEditingController();

  /// Die Route, die dieser Bildschirm repräsentiert.
  final String route = '/bugReportPage';

  /// Konstruktor für die BugReportForm, der den Schlüssel an die Superklasse weitergibt.
  BugReportForm({super.key});

  @override
  ConsumerState<BugReportForm> createState() => _BugReportFormState();
}

class _BugReportFormState extends ConsumerState<BugReportForm> {
  final describeTheBugNode = FocusNode();
  final bugTextController = TextEditingController();

  @override
  void dispose() {
    describeTheBugNode.dispose();
    bugTextController.dispose();
    super.dispose();
  }

  /// Die Build-Methode, die das Widget erstellt.
  @override
  Widget build(BuildContext context) {
    /// Zustand (State) des Apps wird überwacht, um Änderungen zu erkennen.
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    /// Rückgabewert des Widgets, ein Scaffold für die gesamte Seite.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(translate.bugReportAppBarTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Widget für die E-Mail-Validierung mit einem Fokusnode für die Navigation.
              EmailValidation(nextNode: describeTheBugNode),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: bugTextController,
                  maxLines: null,
                  focusNode: describeTheBugNode,
                  decoration: InputDecoration(
                    border: settingsButtonsBorder,
                    label: Text(translate.describeTheBug),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final uri = Uri.parse('https://capis.cdemy.de/appbug.php');
                  final map = <String, dynamic>{};
                  map['app'] = 'Trinkgeld';
                  map['subject'] = 'XXXX';
                  map['body'] = bugTextController.text;
                  final response = await http
                      .post(uri, body: map)
                      .timeout(const Duration(seconds: 10));
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(response.statusCode == 200
                            ? 'Gesendet'
                            : 'Fehler')),
                  );
                  if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Senden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
