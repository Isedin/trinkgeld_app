import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/models/bug_report_form.dart';
import 'package:trinkgeld_app/models/language.dart';
import 'package:trinkgeld_app/presentation/home_view/home_view.dart';
import 'package:trinkgeld_app/providers/appstate_provider.dart';

WidgetRef? globalRef;
void main() {
  //diese Funktion lässt oberen import package laufen
  runApp(const ProviderScope(child: MyApp()));
}

final refAppState = NotifierProvider<AppstateProvider, Appstate>(
  () => AppstateProvider(),
);
///das ist eine Variable die zwei Sprachen speichert!
const globalLanguageLibrary = [German(), English()];

class MyApp extends ConsumerWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(refAppState);
    globalRef = ref;
    final a = ThemeData.light(useMaterial3: true);
    return MaterialApp(
      theme: a,
      darkTheme: ThemeData.dark(useMaterial3: false),
      themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      routes: {
        BugReportForm().route: (context) => BugReportForm(),
      },
    );
  }
}


