import 'package:flutter/material.dart';
class myTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  const myTextField({
    super.key, required this.hintText, required this.labelText, required this.controller, required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // keyboardType: TextInputType.number,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          label: Text(labelText),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )
      ),
    );
  }
}