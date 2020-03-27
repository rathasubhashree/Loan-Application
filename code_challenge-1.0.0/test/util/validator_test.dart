import 'package:flutter_test/flutter_test.dart';
import 'package:code_test/util/validator.dart';

void main() {
  final formValidator = FormValidator();
  test('Name textfield is validated', () {
    expect(true, formValidator.validateName("first"));
  });

  test('Email textfield is validated', () {
    expect(false, formValidator.validateEmail("test"));
  });

  test('Email textfield is validated', () {
    expect(true, formValidator.validateEmail("test@test.com"));
  });

  test('Loan amount textfield is validated', () {
    expect(true, formValidator.validateLoanAmount("10000"));
  });

  test('Loan amount textfield is validated', () {
    expect(false, formValidator.validateLoanAmount("loan"));
  });

  test('checkAndTrim method works', () {
    expect("loan", formValidator.checkAndTrim("   loan    "));
  });

  test('checkAndTrim method works for null', () {
    expect(null, formValidator.checkAndTrim(null));
  });
}