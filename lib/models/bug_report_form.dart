import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/email_validation.dart';

/// Die Klasse BugReportForm erweitert ConsumerWidget, was darauf hinweist, dass es sich um einen Widget handelt, der auf Änderungen reagieren kann.
class BugReportForm extends ConsumerWidget {
  /// FocusNode für das Eingabefeld "describeTheBug".
  final describeTheBugNode = FocusNode();

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
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Center(
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
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: null,
                            focusNode: describeTheBugNode,
                            decoration: InputDecoration(
                              border: settingsButtonsBorder,
                              label: Text(translate.describeTheBug),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
