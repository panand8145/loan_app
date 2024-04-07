import 'package:equatable/equatable.dart';
import 'model/bank_load_data_model.dart';

enum LoanStatus { NONE, INITIAL, RESET, LOADING, SUCCESS, FAILED }

abstract class LoanState extends Equatable {
  final LoanStatus status;
  final BankLoanDataModel? loanDataModel;

  LoanState(this.status, [this.loanDataModel]);

  @override
  List<Object?> get props => [status, loanDataModel];
}

class LoanInitial extends LoanState {
  LoanInitial(super.status);

  @override
  List<Object?> get props => [status];
}

class LoanLoading extends LoanState {
  LoanLoading(super.status);

  @override
  List<Object?> get props => [status];
}

class LoanResponse extends LoanState {
  LoanResponse(super.status, this.loanDataModel);

  @override
  final BankLoanDataModel loanDataModel;

  @override
  List<Object?> get props => [status, loanDataModel];
}

class LoanFailed extends LoanState {
  LoanFailed(super.status);

  @override
  List<Object?> get props => [status];
}