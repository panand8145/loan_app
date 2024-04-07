import 'package:flutter/material.dart';

class LoanProcessButton extends StatelessWidget {
  const LoanProcessButton(
      {super.key, required this.onClick, required this.label});

  final Function() onClick;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Ink(
        decoration: const BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 55.0, minWidth: 150.0),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
