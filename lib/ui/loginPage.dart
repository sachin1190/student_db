import 'package:flutter/material.dart';
import 'package:studen_db/utilities/Validators.dart';
import 'package:studen_db/utilities/appConstants.dart';
import 'package:studen_db/models/user.dart';
import 'package:studen_db/utilities/constantFields.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginForm = new GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          elevation: 20,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: AppConstants.primaryCol,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Form(
              key: loginForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: AppConstants.secondaryCol, fontSize: 24),
                    ),
                  ),
                  getTextFieldLarge(usernameController, 'Username'),
                  getPasswordField(passwordController, () {
                    setState(() {
                      obs = !obs;
                    });
                  }, 'Password', obs),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: RaisedButton(
                        onPressed: () {
                          if (loginForm.currentState.validate()) {
                            if (checkValidity(usernameController.text,
                                passwordController.text))
                              Navigator.pushNamed(context, '/studentForm');
                            else
                              showSnackBar();
                          }
                        },
                        color: AppConstants.secondaryCol,
                        child: Text('Login'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Invalid Username or Password'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        textColor: AppConstants.secondaryCol,
        label: 'OK',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
  }
}
