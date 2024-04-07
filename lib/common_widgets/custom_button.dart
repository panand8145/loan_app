import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onClick, required this.label});

  final Function() onClick;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Ink(
        decoration: const BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: FittedBox(
          child: Container(
            constraints: const BoxConstraints(minHeight: 45.0, minWidth: 150.0),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14.0,
                    color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
