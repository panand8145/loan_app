import '../../utils/constants.dart';
import 'model/base_response.dart';

class LoanRepository {
  Future<BaseResponse> fetchBankDetailsForLoan() async {
    BaseResponse response = BaseResponse(
        statusCode: 200, message: "Success", responseData: bankLoanJsonPayload);
    return Future.value(response);
  }
}
