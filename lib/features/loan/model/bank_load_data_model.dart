import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BankLoanDataModel extends Equatable {
  String? name;
  int? maxLoan;
  int? recommendedLoan;
  int? minLoan;
  List<int>? emiMonths;
  List<Color>? emiColors = [];
  double? interestRate;
  List<Banks>? banks;
  Banks? selectedBank; // User selected bank
  int selectedLoanAmount = 0; // How much amount of loan user want
  int selectedEmiPlan = 0; // Hold how many month of emi user want
  final Random _random = Random();

  BankLoanDataModel(
      {this.name,
      this.maxLoan = 0,
      this.recommendedLoan = 0,
      this.minLoan = 0,
      this.emiMonths,
      this.emiColors,
      this.interestRate,
      this.banks,
      this.selectedBank,
      this.selectedLoanAmount = 0,
      this.selectedEmiPlan = 0});

  BankLoanDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    maxLoan = json['maxLoan'];
    recommendedLoan = json['recommendedLoan'];
    selectedLoanAmount = json['recommendedLoan'];
    minLoan = json['minLoan'];
    emiMonths = json['emiMonths'].cast<int>();
    if (emiMonths != null && emiMonths!.isNotEmpty) {
      emiColors = [];
      emiMonths!.forEach((element) {
        emiColors!.add(Color.fromARGB(255, _random.nextInt(16) * 16,
            _random.nextInt(16) * 16, _random.nextInt(16) * 16));
      });
    }
    interestRate = json['interestRate'];
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['maxLoan'] = this.maxLoan;
    data['recommendedLoan'] = this.recommendedLoan;
    data['minLoan'] = this.minLoan;
    data['emiMonths'] = this.emiMonths;
    data['interestRate'] = this.interestRate;
    if (this.banks != null) {
      data['banks'] = this.banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  BankLoanDataModel copyWith(
          {num? id,
          String? title,
          String? description,
          num? price,
          bool? isBookmark,
          int? selectedLoanAmount,
          int? selectedEmiPlan,
          Banks? selectedBank}) =>
      BankLoanDataModel(
        name: name ?? this.name,
        maxLoan: maxLoan ?? this.maxLoan,
        recommendedLoan: recommendedLoan ?? this.recommendedLoan,
        minLoan: minLoan ?? this.minLoan,
        emiMonths: emiMonths ?? this.emiMonths,
        emiColors: this.emiColors,
        interestRate: interestRate ?? this.interestRate,
        banks: banks ?? this.banks,
        selectedLoanAmount: selectedLoanAmount ?? this.selectedLoanAmount,
        selectedEmiPlan: selectedEmiPlan ?? this.selectedEmiPlan,
        selectedBank: selectedBank ?? this.selectedBank,
      );

  @override
  List<Object?> get props => [
        name,
        maxLoan,
        recommendedLoan,
        minLoan,
        emiMonths,
        emiColors,
        interestRate,
        banks,
        selectedBank,
        selectedLoanAmount,
        selectedEmiPlan
      ];
}

class Banks {
  String? name;
  String? iconPath;
  String? accountNo;

  Banks({this.name, this.iconPath, this.accountNo});

  Banks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconPath = json['iconPath'];
    accountNo = json['accountNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iconPath'] = this.iconPath;
    data['accountNo'] = this.accountNo;
    return data;
  }
}
