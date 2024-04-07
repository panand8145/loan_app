import 'dart:core';
import 'package:equatable/equatable.dart';

enum AccountMode { LOGIN, REGISTER }

enum AuthStatus { NONE, LOADING, SUCCESS, FAILED }

final class AuthState extends Equatable {
  final AccountMode accountMode;
  final String userName;
  final bool isUserNameValid;
  final String emailAddress;
  final String password;
  final bool isEmailValid;
  final String emailErrorMsg;
  final bool isPasswordValid;
  final String passwordErrorMsg;
  final bool isLoading;
  final AuthStatus authStatus;
  final String authStatusErrorMsg;

  const AuthState(
      {required this.userName,
      required this.isUserNameValid,
      required this.accountMode,
      required this.emailAddress,
      required this.isEmailValid,
      required this.emailErrorMsg,
      required this.password,
      required this.isPasswordValid,
      required this.passwordErrorMsg,
      required this.isLoading,
      required this.authStatus,
      required this.authStatusErrorMsg});

  @override
  List<Object?> get props => [
        userName,
        isUserNameValid,
        accountMode,
        emailAddress,
        password,
        isEmailValid,
        isPasswordValid,
        emailErrorMsg,
        passwordErrorMsg,
        isLoading,
        authStatus,
        authStatusErrorMsg
      ];

  AuthState copyWith({
    String? userName,
    bool? isUserName,
    AccountMode? mode,
    String? emailAddress,
    String? emailErrorMsg,
    String? password,
    String? passwordErrorMsg,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isLoading,
    AuthStatus? authStatus,
    String? authStatusErrorMsg,
  }) {
    return AuthState(
      userName: userName ?? this.userName,
      isUserNameValid: isUserName ?? this.isUserNameValid,
      accountMode: mode ?? accountMode,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      emailErrorMsg: emailErrorMsg ?? this.emailErrorMsg,
      passwordErrorMsg: passwordErrorMsg ?? this.passwordErrorMsg,
      isLoading: isLoading ?? this.isLoading,
      authStatus: authStatus ?? this.authStatus,
      authStatusErrorMsg: authStatusErrorMsg ?? this.authStatusErrorMsg,
    );
  }
}
