import 'package:flutter/material.dart';
import 'package:code_test/view/application_form_screen.dart';
import 'package:code_test/view/loan_application_list.dart';

void main() => runApp(LoanApplicationApp());

class LoanApplicationApp extends StatefulWidget {
  LoanApplicationApp({Key key}) : super(key: key);

  @override
  LoanApplicationAppState createState() => LoanApplicationAppState();
}

class LoanApplicationAppState extends State<LoanApplicationApp> {
  int _currentIndex = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return LoanApplicationForm();
      case 1:
        return LoanApplicationList();
      default:
        return LoanApplicationForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Fintech",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Fintech"),
          ),
          body: callPage(_currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value) {
              _currentIndex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle),
                  title: Text("Loan Application form")),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                title: Text("Loan Application List"),
              ),
            ],
          ),
        ));
  }
}
