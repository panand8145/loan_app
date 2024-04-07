import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meshwork_practical_assignment/common_widgets/custom_button.dart';
import 'package:meshwork_practical_assignment/features/authentication/auth_screen.dart';
import 'package:meshwork_practical_assignment/resources/icons.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../authentication/auth_bloc.dart';
import '../authentication/auth_repository.dart';
import '../loan/loan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => AuthBloc(_authRepository),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: OutlinedButton(
                      onPressed: () async {
                        bool flag = await context.read<AuthBloc>().userLogout();
                        if (flag) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthScreen()),
                          );
                        }
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SvgPicture.asset(
                  IconsSVG.loanBanner,
                  height: height / 2.5,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                CustomButton(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoanScreen()),
                      );
                    },
                    label: "START"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
