import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'loan_repository.dart';
import 'loan_state.dart';
import 'model/bank_load_data_model.dart';
import 'model/base_response.dart';

class LoanBloc extends Cubit<LoanState> {
  final LoanRepository loanRepository;

  LoanBloc(this.loanRepository) : super(LoanInitial(LoanStatus.NONE)) {
    fetchBankLoanData();
  }

  // FETCH BANK DATA FROM SERVER
  void fetchBankLoanData() async {
    emit(LoanLoading(LoanStatus.LOADING));
    BaseResponse response = await loanRepository.fetchBankDetailsForLoan();
    if (response.statusCode == 200) {
      // SUCCESS
      final bankResponseData = json.decode(response.responseData);
      BankLoanDataModel model = BankLoanDataModel.fromJson(bankResponseData);
      emit(LoanResponse(LoanStatus.SUCCESS, model));
    } else {
      // FAILED
      emit(LoanFailed(LoanStatus.FAILED));
    }
  }

  // UPDATE LOAN AMOUNT
  void updateLoanAmount(double amount) {
    BankLoanDataModel model =
        state.loanDataModel!.copyWith(selectedLoanAmount: amount.toInt());
    emit(LoanResponse(LoanStatus.SUCCESS, model));
  }

  // USER SELECTED EMI PLAN
  void updateEmiPlan(int emiNoMonth) {
    BankLoanDataModel model =
        state.loanDataModel!.copyWith(selectedEmiPlan: emiNoMonth);
    emit(LoanResponse(LoanStatus.SUCCESS, model));
  }

  // USER SELECTED BANK
  void updateBankForLoan(Banks? bank) {
    BankLoanDataModel model = state.loanDataModel!.copyWith(selectedBank: bank);
    emit(LoanResponse(LoanStatus.SUCCESS, model));
  }
}
