import 'package:flutter/material.dart';

class FolllowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const FolllowButton(
      {super.key,
      required this.backgroundColor,
      required this.borderColor,
      this.function,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 45,
      padding: const EdgeInsets.only(top: 3),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
