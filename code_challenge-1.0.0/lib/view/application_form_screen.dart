import 'package:code_test/api/api.dart';
import 'package:code_test/models/application.dart';
import 'package:code_test/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class LoanApplicationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoanApplicationFormState();
  }
}

class LoanApplicationFormState extends State<LoanApplicationForm> {
  String _firstName;
  String _lastName;
  String _email;
  String _loanAmount;
  final firstNameHolder = TextEditingController();
  final lastNameHolder = TextEditingController();
  final emailHolder = TextEditingController();
  final loanAmountHolder = TextEditingController();
  FocusNode firstNameFocusNode;
  FormValidator formValidator;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//This method clears the textfields text
  clearTextInput() {
    firstNameHolder.clear();
    lastNameHolder.clear();
    emailHolder.clear();
    loanAmountHolder.clear();
    firstNameFocusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();

    firstNameFocusNode = FocusNode();
    formValidator = FormValidator();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    firstNameFocusNode.dispose();
    super.dispose();
  }

//This method will create first name texfield and will check validation.
  Widget _buildFirstName() {
    return TextFormField(
      focusNode: firstNameFocusNode,
      controller: firstNameHolder,
      decoration: InputDecoration(
          labelText: "First Name", border: OutlineInputBorder()),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: (value) {
        return formValidator.validateName(value)
            ? null
            : "First name is Required";
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

//This method will create last name texfield and will check validation.
  Widget _buildLastName() {
    return TextFormField(
      controller: lastNameHolder,
      decoration:
          InputDecoration(labelText: "Last Name", border: OutlineInputBorder()),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: (value) {
        return formValidator.validateName(value)
            ? null
            : "Last name is Required";
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

//This method will create email texfield and will check validation.
  Widget _buildEmail() {
    return TextFormField(
      controller: emailHolder,
      decoration: InputDecoration(
          labelText: "Email Address", border: OutlineInputBorder()),
      autocorrect: false,
      validator: (value) {
        return formValidator.validateEmail(value)
            ? null
            : "Enter Valid Email (eg: test@test.com)";
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

//This method will create loan amount texfield and will check validation.
  Widget _buildLoanAmount() {
    return TextFormField(
      controller: loanAmountHolder,
      decoration: InputDecoration(
          labelText: "Loan Amount", border: OutlineInputBorder()),
      autocorrect: false,
      validator: (value) {
        return formValidator.validateLoanAmount(value)
            ? null
            : "Loan amount should be between 10,000kr to 500,000kr";
      },
      onSaved: (String value) {
        _loanAmount = value;
      },
    );
  }

//This method will show ios style alert pop up
  Future<void> _handleAlert(String alertTitle, String alertMessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(alertTitle),
          content: Text(alertMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

//This method will show waiting progress indicator
  waitingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new Center(
          child: new SizedBox(
            width: 40.0,
            height: 40.0,
            child: const CircularProgressIndicator(
              value: null,
              strokeWidth: 2.0,
            ),
          ),
        );
      },
    );
  }

// This method has logic to submit an application.
  void submitApplication() {
    Application application = Application(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        loanAmount: double.tryParse(_loanAmount));
    API api = MockAPI();
    waitingDialog(context);
    api.submitApplication(application).then((application) {
      _handleAlert("Thank you " + application.firstName,
          ".\nYour loan application is Submitted.");
      clearTextInput();
    }).catchError((exception) {
      _handleAlert("Error", exception.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildFirstName(),
            _buildLastName(),
            _buildEmail(),
            _buildLoanAmount(),
            SizedBox(height: 100),
            CupertinoButton(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                _formKey.currentState.save();

                submitApplication();
              },
            ),
          ],
        ),
      ),
    );
  }
}
