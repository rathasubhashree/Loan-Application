class FormValidator {
  final int minCharacterLength = 1;
  final int maxCharacterLength = 50;
  final int maxLoanAmount = 500000;
  final int minLoanAmount = 10000;
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

//This method validate first name and last name textfield text

  bool validateName(String value) {
    value = checkAndTrim(value);
    print((isNotEmpty(value) &&
        value.length < minCharacterLength &&
        value.length > maxCharacterLength));
    return (isNotEmpty(value) &&
        value.length >= minCharacterLength &&
        value.length <= maxCharacterLength);
  }

//This method validates email textfield text
  bool validateEmail(String value) {
    value = checkAndTrim(value);
    RegExp regex = new RegExp(pattern);
    return (isNotEmpty(value) && regex.hasMatch(value));
  }

//This method validates loan amount textfield text
  bool validateLoanAmount(String value) {
    value = checkAndTrim(value);
    if (isNotEmpty(value)) {
      int loanAmountValue = int.tryParse(value);
      return (loanAmountValue != null &&
          loanAmountValue <= maxLoanAmount &&
          loanAmountValue >= minLoanAmount);
    } else {
      return false;
    }
  }

  String checkAndTrim(String value) {
    String returnValue;
    if (value != null && value.isNotEmpty) {
      returnValue = value.trim();
    }
    return returnValue;
  }

  bool isNotEmpty(String value) {
    return checkAndTrim(value) != null;
  }
}
