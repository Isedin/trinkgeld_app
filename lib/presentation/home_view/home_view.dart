import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/presentation/home_view/input_section.dart';
import 'package:trinkgeld_app/presentation/home_view/settings_section.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    //appstate beinhgaltet slle Infornationen die ich brauche
    final appstate = ref.watch(refAppState);
    final appstateProvider = ref.read(refAppState.notifier);
    final parserString =
        appstateProvider.getCountryById(appstate.selectedCountry)!.flag;
    final translate = appstate.selectedLanguage;
    final emojiLibrary = EmojiParser();
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
                        child: Text(
                          emojiLibrary.emojify(country.flag),
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
