import 'package:flutter/material.dart';
import '../model/bank_load_data_model.dart';

class BankOptionWidget extends StatelessWidget {
  const BankOptionWidget(
      {super.key,
      required this.isSelected,
      required this.bank,
      required this.onClick});

  final Banks? bank;
  final bool isSelected;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              bank!.iconPath!,
              width: 24.0,
              height: 24.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bank!.name ?? "Bank name",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(bank!.accountNo ?? "Bank account no"),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                height: 24.0,
                width: 24.0,
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.black87,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
