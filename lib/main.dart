import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future _logStatus() async {
    SharedPreferences status = await SharedPreferences.getInstance();
    return status.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _logStatus(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            //wait for async to load
            if (snapshot.data == false) {
              return Login();
            } else {
              return Home();
            }
          }
          return CircularProgressIndicator(
            color: Colors.green,
          );
        },
      ),
      routes: {
        Login.path: (context) => Login(),
        Home.path: (context) => Home()
      },
    );
  }
}
