import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double? size;

  const PopButton({super.key, this.text, this.icon, this.onPressed, this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
