import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/presentation/home_view/home_view.dart';
import 'package:trinkgeld_app/providers/appstate_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final refAppState = NotifierProvider<AppstateProvider, Appstate>(
  () => AppstateProvider(),
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(refAppState);
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: false),
      themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}

/*
Die oben gegebenen Codezeilen definieren eine Flutter-Anwendung, die von der Klasse "MyApp" abgeleitet ist und das "ConsumerWidget"-Mixin verwendet.

Die Variable "globalRef" vom Typ "WidgetRef?" wird deklariert und initialisiert. Diese Variable wird verwendet, um auf den Widget-Referenzkontext zuzugreifen.

Die Funktion "main" definiert den Einstiegspunkt der Anwendung. Sie ruft die Funktion "runApp" auf und übergibt ihr ein neues Objekt der Klasse "ProviderScope", das als Kind das Widget "MyApp" enthält. Dies ermöglicht die Verwendung des Provider-Pakets zur Verwaltung des Zustands der Anwendung.

Die Variable "refAppState" ist ein NotifierProvider, der den Zustand der Anwendung verwaltet. Es wird eine Instanz der Klasse "AppstateProvider" erstellt und an den NotifierProvider übergeben.

Die Klasse "MyApp" ist ein ConsumerWidget, das das Build-Methode überschreibt. Das Build-Methode erhält einen BuildContext und eine WidgetRef als Parameter. Der Zustand der Anwendung wird aus dem refAppState abgerufen und in der Variablen "state" gespeichert.

Die Variable "a" enthält ein ThemeData-Objekt für das helle Thema mit der Option useMaterial3 auf true gesetzt.

Das MaterialApp-Widget wird erstellt und zurückgegeben. Es verwendet das helle Thema (a) für das Standardthema, das dunkle Thema (ThemeData.dark) für den Dunkelmodus basierend auf dem Wert von state.darkMode und zeigt kein Debug-Banner an. Das HomeView-Widget wird als Startseite festgelegt.

Insgesamt initialisiert dieser Code die Flutter-Anwendung, konfiguriert den Zustand der Anwendung und definiert das Aussehen und Verhalten der Benutzeroberfläche.
*/


/*Types of Widgets
1. StatelessWidget
2. StatefulWidget
3. InheritedWidget
*/

/*State
1. Material Design - created by Google
2. Cupertino Design - created by Apple
*/



//ReordableListView

// class _GeordneteCountryListeState extends StatefulWidget {
//   const _GeordneteCountryListeState({super.key});

//   @override
//   State<_GeordneteCountryListeState> createState() => _GeordneteCountryListeStateState();
// }

// class _GeordneteCountryListeStateState extends State<_GeordneteCountryListeState> {
// final List<int> items = List<int>.generate(10, (int index) => index);



//   @override
//   Widget build(BuildContext context) {
//     return  ReorderableListView(
//       children: List.generate(items.length, (index) => ListTile(
//         key: Key('$index'),
//         trailing: Icon(Icons.drag_handle_sharp),
//       ),
//       ),
//       onReorder: (int (oldIndex, int newIndex) {
//         setState(() {
//           if (oldIndex < newIndex) {
//             newIndex -=1;
//           }
//           final int item = items.removeAt(oldIndex);
//           items.insert(newIndex, item);
//           });
//       }),
//     );
//   }
// }
