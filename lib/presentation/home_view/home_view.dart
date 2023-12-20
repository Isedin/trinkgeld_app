import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/presentation/home_view/input_section.dart';
import 'package:trinkgeld_app/presentation/home_view/settings_section.dart';

/// Die Klasse HomeView repräsentiert die Hauptansicht der App.
class HomeView extends ConsumerStatefulWidget {
  /// Konstruktor für die Initialisierung von Instanzvariablen.
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

// Der State für das HomeView-Widget.
class _HomeViewState extends ConsumerState<HomeView> {
  // Variable zur Verfolgung der aktuellen Seite (0 für Berechnungen, 1 für Einstellungen).
  int page = 0;

  @override
  Widget build(BuildContext context) {
    // Der Zustand (State) der App wird überwacht, um Änderungen zu erkennen.
    final appstate = ref.watch(refAppState);
    // Der Zugriff auf den App-Zustandsanbieter ermöglicht das Aktualisieren des Zustands.
    final appstateProvider = ref.read(refAppState.notifier);
    // Abrufen der Länderflagge als Emoji für die aktuell ausgewählte Sprache.
    final parserString =
        appstateProvider.getCountryById(appstate.selectedCountry)!.flag;
    final translate = appstate.selectedLanguage;
    final emojiLibrary = EmojiParser();
    // Rückgabewert des Widgets, ein Scaffold mit AppBar, Body und BottomNavigationBar.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(page == 0
            ? appstate.selectedLanguage.title
            : appstate.selectedLanguage.settings),
        centerTitle: true,
        actions: [
          DropdownButton(
              padding: const EdgeInsets.only(right: 12),
              hint: Text(
                emojiLibrary.emojify(parserString),
              ),
              items: appstate.countries
                  .map((country) => DropdownMenuItem(
                        value: country,
                        child: Row(
                          children: [
                            Text(
                              emojiLibrary.emojify(country.flag),
                            ),
                            Text(
                              emojiLibrary.emojify(country.iso),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                log(value.toString());
                if (value != null) {
                  appstateProvider.changeCountry(value);
                }
              }),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          page == 0 ? const InputSection() : const SettingsSection(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (zahl) {
          setState(() {
            page = zahl;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.green[900],
            icon: const Icon(
              Icons.calculate,
              size: 25,
            ),
            label: translate.bottomButtonCalculate,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
              size: 25,
            ),
            label: translate.bottomButtonSettings,
          ),
        ],
      ),
    );
  }
}
