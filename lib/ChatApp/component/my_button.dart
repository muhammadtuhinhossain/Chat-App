import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const ButtonWidget({
    super.key, required this.text, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(text,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
      ),
    );
  }
}