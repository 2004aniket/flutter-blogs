import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String HintText;
  final TextEditingController controller;
  final bool isobscuretext;
  const AuthField(
      {super.key,
      required this.HintText,
      required this.controller,
      this.isobscuretext = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isobscuretext,
      decoration: InputDecoration(
        hintText: HintText,
      ),
      validator: (value) {
        return null;
      },
    );
  }
}
