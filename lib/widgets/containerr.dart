import 'package:flutter/material.dart';

class Containerr extends StatelessWidget {
  const Containerr({super.key, required this.text, required this.onTap});

  final Widget text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
