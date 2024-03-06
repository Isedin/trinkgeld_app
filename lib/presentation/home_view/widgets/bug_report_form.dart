import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:trinkgeld_app/presentation/home_view/widgets/email_validation.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

/// Die Klasse BugReportForm erweitert ConsumerWidget, was darauf hinweist, dass es sich um einen Widget handelt, der auf Änderungen reagieren kann.
class BugReportForm extends ConsumerWidget {
  /// FocusNode für das Eingabefeld "describeTheBug".
  final describeTheBugNode = FocusNode();

  ///Überprüft den Text der im Feld Bug Report eingegeben wird
  final bugTextController = TextEditingController();

  /// Die Route, die dieser Bildschirm repräsentiert.
  final String route = '/bugReportPage';

  /// Konstruktor für die BugReportForm, der den Schlüssel an die Superklasse weitergibt.
  BugReportForm({super.key});

  /// Die Build-Methode, die das Widget erstellt.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final emailController = TextEditingController();
    // var email = "isedin_k@yahoo.com";
    // bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
    //     .hasMatch(email);
    // print(emailValid);
    /// Zustand (State) des Apps wird überwacht, um Änderungen zu erkennen.
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30,
        ),
      ),
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
              EmailValidation(
                nextNode: describeTheBugNode,
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     border: settingsButtonsBorder,
              //     label: Text(translate.eMailInput),
              //     hintText: 'Enter Your Email',
              //   ),
              // ),
              const SizedBox(
                height: 25,
              ),
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
                  final response =
                      await http.post(uri, body: map);
                      if (response.statusCode == 200) {
                        log('success');
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
