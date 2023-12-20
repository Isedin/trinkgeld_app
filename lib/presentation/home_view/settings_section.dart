// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/dialog_widget.dart';

/// Widget-Klasse für MyBug
class MyBug extends StatelessWidget {
  /// Route für das Widget
  final route = 'mybug';

  /// Konstruktor für MyBug
  const MyBug({super.key});

  /// Überschreiben der build-Methode
  @override

  /// Rückgabe eines MaterialApp-Widgets (aktuell ohne konkreten Inhalt)
  Widget build(BuildContext context) => const MaterialApp();
}

/// Widget-Klasse für Einstellungen
class SettingsSection extends ConsumerWidget {
  /// Konstruktor für SettingsSection mit optionalem Schlüssel
  const SettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30,
        ),
      ),
    );
    final emojiLibrary = EmojiParser();
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    final appstateProvider = ref.read(
      refAppState.notifier,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: settingsButtonsBorder,
              label: Text(appstate.selectedLanguage.ownName),
            ),
            items: globalLanguageLibrary
                //  [],
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.ownName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              log('onChanged Language $value');
              if (value != null) {
                appstateProvider.changeLanguage(value);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: settingsButtonsBorder,
              labelText: 'FAQ',
            ),
          ),
        ),
        //bugReport
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextButton(
            child: Text(translate.bugReport),
            onPressed: () {
              Navigator.pushNamed(context, '/bugReportPage');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextButton(
            child: Text(translate.ownTippSettingButton),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  ref: ref,
                ),
              );
              log('message');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 3,
          ),
          child: Container(
            alignment: Alignment.center,
            height: 30,
            width: 50,
            child: IconButton(
              icon: const Icon(
                Icons.brightness_6,
                size: 30,
              ),
              onPressed: () {
                appstateProvider.switchDarkmode();
              },
            ),
          ),
        ),
      ],
    );
  }
}
