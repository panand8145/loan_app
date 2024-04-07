import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthRepository _authRepo;

  AuthBloc(this._authRepo)
      : super(const AuthState(
          userName: "",
          isUserNameValid: false,
          accountMode: AccountMode.LOGIN,
          emailAddress: '',
          password: '',
          isEmailValid: true,
          isPasswordValid: true,
          emailErrorMsg: '',
          passwordErrorMsg: '',
          isLoading: false,
          authStatus: AuthStatus.NONE,
          authStatusErrorMsg: '',
        ));

  void emailChange(String email) {
    final bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    emit(state.copyWith(
        isEmailValid: isValid,
        emailAddress: email,
        emailErrorMsg: "invalid email address"));
  }

  void passwordChange(String password) {
    bool isValid = password.length >= 8;
    emit(state.copyWith(
        isPasswordValid: isValid,
        password: password,
        passwordErrorMsg: "Password must be 8 character long."));
  }

  void userNameChange(String name) {
    emit(state.copyWith(isUserName: name.isEmpty, userName: name));
  }

  void accountVerificationWithEmailPassword(AccountMode mode) async {
    if (state.isEmailValid &&
        state.isPasswordValid &&
        state.emailAddress.isNotEmpty &&
        state.password.isNotEmpty) {
      // CALL FIREBASE FUNCTION
      String errorMsg = "";
      emit(state.copyWith(isLoading: true, authStatus: AuthStatus.LOADING));
      if (mode == AccountMode.LOGIN) {
        // LOGIN
        errorMsg = await _authRepo.userLoginWithFirebase(
            emailAddress: state.emailAddress, password: state.password);
      } else if (mode == AccountMode.REGISTER) {
        if (state.userName.isEmpty) {
          emit(state.copyWith(
            isUserName: false,
            authStatus: AuthStatus.NONE,
          ));
          return;
        }
        // REGISTER
        errorMsg = await _authRepo.userRegistrationWithFirebase(
            name: state.userName,
            emailAddress: state.emailAddress,
            password: state.password);
      }
      if (errorMsg.isEmpty) {
        emit(state.copyWith(
            isLoading: false,
            authStatus: AuthStatus.SUCCESS,
            authStatusErrorMsg: ""));
      } else {
        emit(state.copyWith(
            isLoading: false,
            authStatus: AuthStatus.FAILED,
            authStatusErrorMsg: errorMsg));
      }
    } else if (state.isEmailValid && state.emailAddress.trim().isEmpty) {
      emit(state.copyWith(
          isEmailValid: false,
          authStatus: AuthStatus.NONE,
          emailErrorMsg: "Enter email address"));
    } else if (state.isPasswordValid && state.password.trim().isEmpty) {
      emit(state.copyWith(
          isPasswordValid: false,
          authStatus: AuthStatus.NONE,
          passwordErrorMsg: "Enter password"));
    }
  }

  void changeAccountMode(AccountMode model) {
    emit(state.copyWith(
      mode:
          model == AccountMode.LOGIN ? AccountMode.REGISTER : AccountMode.LOGIN,
      userName: "",
      emailAddress: '',
      password: '',
      isEmailValid: true,
      isPasswordValid: true,
      emailErrorMsg: '',
      passwordErrorMsg: '',
      authStatus: AuthStatus.NONE,
    ));
  }

  Future<bool> userLogout() async {
    return await _authRepo.userLogout();
  }
}
