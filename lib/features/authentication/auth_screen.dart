import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_widgets/custom_button.dart';
import '../../common_widgets/loading_dialog.dart';
import '../home/home_screen.dart';
import 'auth_bloc.dart';
import 'auth_repository.dart';
import 'auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _authRepository = AuthRepository();
  final _userName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(_authRepository),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(25.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.ac_unit,
                  color: Colors.green,
                  size: 54.0,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    _userName.text = state.userName;
                    return Visibility(
                      visible: state.accountMode == AccountMode.REGISTER,
                      child: TextField(
                        onChanged: (text) =>
                            context.read<AuthBloc>().userNameChange(text),
                        controller: _userName,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Name",
                          errorText:
                              state.isUserNameValid ? "Enter your name." : null,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    _emailAddress.text = state.emailAddress;
                    return TextField(
                      onChanged: (text) =>
                          context.read<AuthBloc>().emailChange(text),
                      controller: _emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Email Address",
                        errorText:
                            state.isEmailValid ? null : state.emailErrorMsg,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    _password.text = state.password;
                    return TextField(
                      onChanged: (text) =>
                          context.read<AuthBloc>().passwordChange(text),
                      controller: _password,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                        errorText: state.isPasswordValid
                            ? null
                            : state.passwordErrorMsg,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                BlocSelector<AuthBloc, AuthState, AccountMode>(
                  selector: (state) => state.accountMode,
                  builder: (context, mode) {
                    return CustomButton(
                      label: mode == AccountMode.LOGIN
                          ? "  LOG IN  "
                          : "  CREATE ACCOUNT  ",
                      onClick: () => context
                          .read<AuthBloc>()
                          .accountVerificationWithEmailPassword(mode),
                    );
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    // handle Login/Create account response
                    if (state.authStatus == AuthStatus.NONE) {
                      // ACCOUNT NOT VERIFY BY USER YET
                    } else if (state.authStatus == AuthStatus.LOADING) {
                      showLoaderDialog(context);
                    } else if (state.authStatus == AuthStatus.SUCCESS) {
                      // WHEN LOGIN OR NEW ACCOUNT COMPLETE
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else if (state.authStatus == AuthStatus.FAILED) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.authStatusErrorMsg),
                      ));
                    }
                  },
                  child: const SizedBox(
                    height: 25.0,
                  ),
                ),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Text(
                      "  OR  ",
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    Expanded(child: Divider())
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                BlocSelector<AuthBloc, AuthState, AccountMode>(
                  selector: (state) => state.accountMode,
                  builder: (context, mode) {
                    return InkWell(
                      onTap: () =>
                          context.read<AuthBloc>().changeAccountMode(mode),
                      child: Text(
                        mode == AccountMode.LOGIN
                            ? "Create new account"
                            : "Log in",
                        style: const TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
