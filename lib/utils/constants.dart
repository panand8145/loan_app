import 'package:intl/intl.dart';

// FIREBASE USER PROFILE ACCESS KEYS
const String keyUserName = "";
const String keyEmail = "";
final formatCurrency =
    NumberFormat.simpleCurrency(locale: "en_US", name: "INR", decimalDigits: 0);
// FETCH BANK LOAN DATA FROM STATIC JSON
const String bankLoanJsonPayload = """{
  "name": "vilash",
  "maxLoan": 500000,
  "recommendedLoan": 150000,
  "minLoan": 10000,
  "emiMonths": [
    12,
    9,
    6,
    3
  ],
  "interestRate": 1.04,
  "banks": [
    {
      "name": "HDFC Bank",
      "iconPath": "assets/pngs/ic_hdfc.png",
      "accountNo": "8382273727172"
    },
    {
      "name": "ICICI Bank",
      "iconPath": "assets/pngs/ic_icici.png",
      "accountNo": "6216712727461"
    }
  ]
}""";
