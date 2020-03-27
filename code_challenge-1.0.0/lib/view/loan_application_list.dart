import 'package:flutter/material.dart';
import 'package:code_test/api/api.dart';
import 'package:code_test/models/application.dart';

class LoanApplicationList extends StatefulWidget {
  LoanApplicationList({Key key}) : super(key: key);
  @override
  LoanApplicationListState createState() => LoanApplicationListState();
}

class LoanApplicationListState extends State<LoanApplicationList> {
  API api = MockAPI();
  Future<List<Application>> applications;

  @override
  void initState() {
    super.initState();
    applications = api.getApplications();
  }

//This method creates user information column to show full name and email.
  Widget createUserColumn(String name, String email) {
    return Expanded(
        child: ListTile(
      leading: Icon(Icons.person_pin),
      title: Text(name, style: TextStyle(fontSize: 18.0, color: Colors.black)),
      subtitle:
          Text(email, style: TextStyle(fontSize: 16.0, color: Colors.blue)),
    ));
  }

//This method creates column for loan amount information.
  Widget createLoanColumn(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18.0, color: Colors.black)),
      ],
    );
  }

//This method will display a list view with loan applications details
  Widget loanApplicationsListView(
      BuildContext context, AsyncSnapshot<List<Application>> loanApplications) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: loanApplications.data.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.lightBlue[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                createUserColumn(loanApplications.data[index].getFullName(),
                    loanApplications.data[index].email),
                createLoanColumn(loanApplications.data[index].getLoanAmount()),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Application>>(
          future: applications,
          builder: (context, loanApplications) {
            if (loanApplications.hasData) {
              return loanApplicationsListView(context, loanApplications);
            } else if (loanApplications.hasError) {
              return Padding(
                  padding: EdgeInsets.all(25),
                  child: Text('${loanApplications.error}',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center));
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
