import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textcolor;
  const DefaultButton(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.color,
      required this.textcolor});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: textcolor))),
      onPressed: onPressed,
      child: child,
    );
  }
}
