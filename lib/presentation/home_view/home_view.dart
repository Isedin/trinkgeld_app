import 'package:flutter/material.dart';
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
    // ignore: avoid_print
    final appstate = ref.watch(refAppState);
    final appstateProvider = ref.read(
      refAppState.notifier,
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: page == 0 ? const Text('TIPPING APP') : const Text('SETTINGS'),
        actions: [
          Text(
            appstateProvider.getCountryById(appstate.selectedCountry)?.name ??
                'lkhlklklhhlk',
          ),
        ],
      ),
      body: Column(
        children: [
          page == 0 ? InputSection() : const SettingsSection(),
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
            icon: const Icon(Icons.calculate),
            label: 'Calculate',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}


// Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         color: page == 0 ? Colors.green[900] : Colors.green[200],
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(
          //             Icons.calculate,
          //             color: Colors.white,
          //             size: 50,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         color: page == 1 ? Colors.green[900] : Colors.green[200],
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(
          //             color: Colors.white,
          //             Icons.settings,
          //             size: 50,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
