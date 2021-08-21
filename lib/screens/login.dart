import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  static const String path = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool spin = false;
  String userName = "";
  String passwd = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 190.0,
                child: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/gameTvLogo.png'),
                  ),
                  radius: 100.0,
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  userName = value;
                  if (value.length < 3 || value.length > 11) {
                    pop("Username must be minimum 3 and maximum 11 characters.");
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 23.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  passwd = value;
                  if (value.length < 3 || value.length > 11) {
                    pop("Password must be minimum 3 and maximum 11 characters.");
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 23.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(35.0),
                  elevation: 4.0,
                  child: MaterialButton(
                    onPressed: buttonStaus,
                    height: 30.0,
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buttonStaus() async {
    if (!(userName.length > 3 && userName.length < 11)) {
      pop("Username must be minimum 3 and maximum 11 characters.");
    } else if (!(passwd.length > 3 && passwd.length < 11)) {
      pop("Password must be minimum 3 and maximum 11 characters.");
    } else {
      if ((userName == "9898989898" || userName == "9876543210") &&
          passwd == "password12") {
        SharedPreferences isLoggedIn = await SharedPreferences.getInstance();
        isLoggedIn.setBool("isLoggedIn", true);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      } else {
        pop("Username or password is incorrect.");
      }
    }
  }

  void pop(String tst) {
    Fluttertoast.showToast(
      msg: tst,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
