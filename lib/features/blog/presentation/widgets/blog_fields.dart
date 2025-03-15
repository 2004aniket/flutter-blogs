import 'package:flutter/material.dart';

class BlogFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogFields(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText field missing";
        }
        return null;
      },
    );
  }
}
