import 'package:currency_decoration/currency_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../loan_bloc.dart';
import '../loan_state.dart';

class LoanRadialWidget extends StatelessWidget {
  const LoanRadialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanBloc, LoanState>(
      builder: (context, state) {
        if (state.loanDataModel == null) {
          return const SizedBox();
        }
        return SizedBox(
          height: 250.0,
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            axes: <RadialAxis>[
              RadialAxis(
                axisLineStyle: const AxisLineStyle(
                    cornerStyle: CornerStyle.bothCurve,
                    thickness: 0.18,
                    thicknessUnit: GaugeSizeUnit.factor),
                startAngle: 95,
                endAngle: 85,
                showTicks: false,
                showLabels: false,
                minimum: double.parse("${state.loanDataModel!.minLoan}"),
                maximum: double.parse("${state.loanDataModel!.maxLoan}"),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: state.loanDataModel == null
                        ? 0.0
                        : double.parse(
                            "${state.loanDataModel!.selectedLoanAmount}"),
                    cornerStyle: CornerStyle.bothCurve,
                    onValueChanged: (val) {
                      context.read<LoanBloc>().updateLoanAmount(val);
                    },
                    enableDragging: true,
                    width: 0.18,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: BlocBuilder<LoanBloc, LoanState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "credit amount",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              CurrencyDecoration(
                                symbol: CurrencySymbol.INR,
                                amount: double.parse(
                                    "${state.loanDataModel?.selectedLoanAmount}"),
                                symbolSeparator: '',
                                currencyValuePlaceStyle:
                                    CurrencyValuePlaceStyle.style2,
                                fractionDigits: 0,
                                primaryTextStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "@${state.loanDataModel?.interestRate}% monthly",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      positionFactor: 0.1,
                      angle: 0),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
