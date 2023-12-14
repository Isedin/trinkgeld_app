import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/email_validation.dart';

class BugReportForm extends ConsumerWidget {
  final describeTheBugNode = FocusNode();
  final String route = '/bugReportPage';
  BugReportForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final emailController = TextEditingController();
    // var email = "isedin_k@yahoo.com";
    // bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
    //     .hasMatch(email);
    // print(emailValid);
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(translate.bugReportAppBarTitle),
      ),
      body: Column(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    maxLines: null,
                    focusNode: describeTheBugNode,
                    decoration: InputDecoration(
                      border: settingsButtonsBorder,
                      label: Text(translate.describeTheBug),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
