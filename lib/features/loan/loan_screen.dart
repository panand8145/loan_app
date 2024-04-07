import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwork_practical_assignment/features/loan/widgets/bank_option_widget.dart';
import 'package:meshwork_practical_assignment/features/loan/widgets/emi_option_widget.dart';
import 'package:meshwork_practical_assignment/features/loan/widgets/loan_radial_widget.dart';
import 'package:rive/rive.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/loan_process_button.dart';
import '../../resources/icons.dart';
import '../../utils/constants.dart';
import '../home/home_screen.dart';
import 'loan_bloc.dart';
import 'loan_repository.dart';
import 'loan_state.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final _repository = LoanRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocProvider<LoanBloc>(
      create: (_) => LoanBloc(_repository),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24.0,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomButton(
                      label: "Apply for loan",
                      onClick: () {
                        showLoanAmountSelectionWidget(height, width);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLoanAmountSelectionWidget(double height, double width) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        minHeight: height / 0.5,
      ),
      builder: (BuildContext context) {
        return BlocProvider<LoanBloc>(
          create: (_) => LoanBloc(_repository),
          child: SizedBox(
            height: height / 0.5,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          size: 24.0,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.question_mark,
                          size: 24.0,
                        ),
                        onTap: () {
                          // display help description
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<LoanBloc, LoanState>(builder: (context, state) {
                  if (state.loanDataModel == null) return const SizedBox();
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              'how much money do you need?',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              'move the dial and set any amount you need upto ${formatCurrency.format(state.loanDataModel!.maxLoan)}',
                              style: const TextStyle(
                                  color: Colors.black38, fontSize: 14.0),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            const LoanRadialWidget(),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Text(
                                  'cstash is instant money will be delivered within seconds',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 14.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                LoanProcessButton(
                  label: "Proceed to EMI selection",
                  onClick: () {
                    showEMIOptionSelectionWidget(height, width);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showEMIOptionSelectionWidget(double height, double width) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: height - 100,
      ),
      builder: (BuildContext context) {
        return BlocProvider<LoanBloc>(
          create: (_) => LoanBloc(_repository),
          child: SizedBox(
            height: height / 0.5,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          size: 24.0,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.question_mark,
                          size: 24.0,
                        ),
                        onTap: () {
                          // display help description
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'how do you wish to repay',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          const Text(
                            'choose one of our recommended plan or make your own',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black38, fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          BlocBuilder<LoanBloc, LoanState>(
                            builder: (context, state) {
                              if (state.loanDataModel == null) {
                                return const SizedBox();
                              }
                              return SizedBox(
                                height: width / 2,
                                child: ListView.builder(
                                  itemCount:
                                      state.loanDataModel?.emiMonths!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    final double perMonthEmiAmount = state
                                            .loanDataModel!.selectedLoanAmount /
                                        state.loanDataModel!.emiMonths![index];
                                    return EmiOptionWidget(
                                      width: width,
                                      emiAmount: perMonthEmiAmount,
                                      isSelected: ((state.loanDataModel!
                                                      .selectedEmiPlan ==
                                                  0 &&
                                              index == 0) ||
                                          state.loanDataModel!
                                                  .emiMonths![index] ==
                                              state.loanDataModel!
                                                  .selectedEmiPlan),
                                      emiMonth: state
                                          .loanDataModel!.emiMonths![index],
                                      isRecommended: index == 0,
                                      clr: state
                                          .loanDataModel!.emiColors![index],
                                      onClick: () {
                                        context.read<LoanBloc>().updateEmiPlan(
                                            state.loanDataModel!
                                                .emiMonths![index]);
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text("Create your own plan"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                LoanProcessButton(
                  label: "Select your bank account",
                  onClick: () {
                    showBankSelectionWidget(height, width);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBankSelectionWidget(double height, double width) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: height - 160,
      ),
      builder: (BuildContext context) {
        return BlocProvider<LoanBloc>(
          create: (_) => LoanBloc(_repository),
          child: SizedBox(
            height: height / 0.5,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          size: 24.0,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.question_mark,
                          size: 24.0,
                        ),
                        onTap: () {
                          // display help description
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'where should we send the money?',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          const Text(
                            'amount will be credited to this bank account, EMI will also be debited from this bank account',
                            style: TextStyle(
                                color: Colors.black38, fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          BlocBuilder<LoanBloc, LoanState>(
                            builder: (context, state) {
                              if (state.loanDataModel == null) {
                                return const SizedBox();
                              }
                              return ListView.builder(
                                itemCount: state.loanDataModel?.banks!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (_, index) {
                                  return BankOptionWidget(
                                    isSelected: ((state.loanDataModel
                                                    ?.selectedBank ==
                                                null &&
                                            index == 0) ||
                                        (state.loanDataModel?.selectedBank !=
                                                null &&
                                            state.loanDataModel?.banks![index]
                                                    .accountNo ==
                                                state.loanDataModel
                                                    ?.selectedBank?.accountNo)),
                                    bank: state.loanDataModel?.banks![index],
                                    onClick: () {
                                      context
                                          .read<LoanBloc>()
                                          .updateBankForLoan(state
                                              .loanDataModel?.banks![index]);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text("Change account"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                LoanProcessButton(
                  label: "Tap for 1-click KYC",
                  onClick: () {
                    showCompleteKyc(height, width);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCompleteKyc(double height, double width) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: height - 220,
      ),
      builder: (BuildContext context) {
        return BlocProvider<LoanBloc>(
          create: (_) => LoanBloc(_repository),
          child: SizedBox(
            height: height / 0.5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'KYX completed',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  const Text(
                    'Amount credited. Please check your account.',
                    style: TextStyle(color: Colors.black38, fontSize: 14.0),
                  ),
                  Center(
                    child: SizedBox(
                      height: width / 1.5,
                      width: width / 1.5,
                      child: const RiveAnimation.asset(
                        RiveAnime.congratulations,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const Text("Done"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
