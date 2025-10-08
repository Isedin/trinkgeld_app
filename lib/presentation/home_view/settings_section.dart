import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/language.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/dialog_widget.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

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
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    final appstateProvider = ref.read(
      refAppState.notifier,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<Language>(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                label: Text(appstate.selectedLanguage.ownName),
              ),
              // Menu color
              dropdownColor: Theme.of(context).colorScheme.surface, 
              // Menu items
              items: const [German(), English()].map((lang) => DropdownMenuItem<Language>(
                  value: lang,
                  child: Text(
                    lang.ownName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )).toList(),
              selectedItemBuilder: (context) => const [German(), English()].map((lang) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.ownName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              onChanged: (value) {
                if (value != null) {
                  appstateProvider.changeLanguage(value);
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SingleChildScrollView(
              child: TextFormField(
                decoration: const InputDecoration(
                  border: settingsButtonsBorder,
                  labelText: 'FAQ',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextButton(
              child: Text(
                translate.bugReport,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/bugReportPage');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextButton(
              child: Text(
                translate.ownTippSettingButton,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: DialogWidget(
                      ref: ref,
                    ),
                  ),
                );
                log('message');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextButton(
              child: Text(
                translate.impressum,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // showDialog(
                // context: context,
                // builder: (context) => AlertDialog(
                //       title: translate is English ? const Text('Impressum') : const Text('Impressum der App'),
                //       content: translate is English
                //           ? const ImpressumWidget(
                //               appName: 'Tipping App',
                //               appVersion: '1.0',
                //             )
                //           : const ImpressumWidget(
                //               appName: 'Trinkgeld App',
                //               appVersion: '1.0',
                //               locale: 'de',
                //             ),
                //       actions: [
                //         TextButton(
                //           onPressed: () => Navigator.pop(context),
                //           child: translate is German ? const Text('Schließen') : const Text('close'),
                //         )
                //       ],
                //     ));
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
              height: 50,
              width: 60,
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
      ),
    );
  }
}
