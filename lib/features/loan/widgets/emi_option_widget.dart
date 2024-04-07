import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/constants.dart';

class EmiOptionWidget extends StatelessWidget {
  EmiOptionWidget(
      {super.key,
      required this.width,
      required this.isSelected,
      required this.emiMonth,
      required this.emiAmount,
      required this.isRecommended,
      required this.onClick,
      required this.clr});

  final Function() onClick;
  final bool isRecommended;
  final bool isSelected;
  final int emiMonth;
  final double emiAmount;
  final double width;
  final Color clr;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            height: width / 2.3,
            width: width / 2.8,
            decoration: BoxDecoration(
                color: clr, borderRadius: BorderRadius.circular(20.0)),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: isSelected,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0))),
                    height: 24.0,
                    width: 24.0,
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isSelected,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0))),
                    height: 24.0,
                    width: 24.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                RichText(
                  text: TextSpan(
                    text: formatCurrency.format(emiAmount),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18.0),
                    children: const <TextSpan>[
                      TextSpan(
                        text: '/ mo',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white60,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'for $emiMonth months',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white60,
                      fontSize: 14.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'See calculations',
                  style: TextStyle(color: Colors.white60, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
        // recommended widget
        Visibility(
          visible: isRecommended,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20.0)),
            child: const Text(
              "recommended",
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ),
        ),
      ],
    );
  }
}
