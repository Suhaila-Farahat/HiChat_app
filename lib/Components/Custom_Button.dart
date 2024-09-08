import 'package:chat_app/Constants.dart';
import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  const CustomButon({super.key, required this.text, this.onTap});

  final String text;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color:textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: appFont
            ),
          ),
        ),
      ),
    );
  }
}
