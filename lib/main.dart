import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/presentation/home_view/home_view.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/bug_report_form.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

// import 'presentation/home_view/home_view.dart';
// import 'presentation/home_view/widgets/bug_report_form.dart';
// import 'providers/_providers.dart';

/// Variable, die eine Referenz auf den Anwendungszustand enthält
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

/// Haupt-Widget für die Anwendung
class MyApp extends ConsumerStatefulWidget {
  /// Konstruktor für MyApp-Widget
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    /// Abrufen des aktuellen App-Zustands über den Provider
    final state = ref.watch(refAppState);

    /// Setzen der globalen Ref-Variable auf die aktuelle Referenz
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: false),
      themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      routes: {BugReportForm().route: (context) => BugReportForm()},
    );
  }
}
