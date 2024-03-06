import 'package:flutter/material.dart';
import 'package:trinkgeld_app/presentation/home_view/input_section.dart';
import 'package:trinkgeld_app/presentation/home_view/settings_section.dart';

///Widget, das ermöglicht, die Seiten zwischen einander umzuschalten
class MyPageView extends StatefulWidget {
  ///super key für oben gennantes Widget
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          InputSection(),
          SettingsSection(),
        ],
      ),
    );
}
