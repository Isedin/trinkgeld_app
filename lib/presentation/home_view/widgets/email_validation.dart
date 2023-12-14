import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';

class EmailValidation extends ConsumerStatefulWidget {
  final FocusNode thisNode = FocusNode();
  final FocusNode nextNode;
  EmailValidation({super.key, required this.nextNode});

  @override
  _EmailValidationState createState() => _EmailValidationState();
}

class _EmailValidationState extends ConsumerState<EmailValidation> {
  //  List<TextEditingController> controllers;
  // List<FocusNode> focusNodes;
  TextEditingController emailController = TextEditingController();

  void validateEmail() {
    final bool isValid = EmailValidator.validate(emailController.text.trim());

    if (isValid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Valid Email')));
      widget.nextNode.requestFocus();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Not a Valid Email')));
      widget.thisNode.requestFocus();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   focusNodes = List.generate(2, (index) => FocusNode());
  //   controllers = List.generate(2, (index) {
  //     final focu = TextEditingController();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;

    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: TextFormField(
              onFieldSubmitted: (value) => validateEmail(),
              controller: emailController,
              focusNode: widget.thisNode,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                labelText: translate.eMailValidationFieldText,

                border: settingsButtonsBorder,
                // enabledBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(30),
                //     borderSide: const BorderSide(color: Colors.green)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
