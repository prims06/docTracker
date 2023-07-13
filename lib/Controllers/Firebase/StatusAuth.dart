import 'package:doc_tracker/Controllers/Firebase/Auth.dart';
import 'package:doc_tracker/Views/home_screen.dart';
import 'package:doc_tracker/Views/nav-bar.dart';
import 'package:doc_tracker/Views/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatusAuth extends StatefulWidget {
  StatusAuth({Key? key}) : super(key: key);
  @override
  State<StatusAuth> createState() => _StatusAuthState();
}

class _StatusAuthState extends State<StatusAuth> {
  User? user;
  bool authentificated = false;
  AuthServices auth = AuthServices();

  Future<void> getuser() async {
    await auth.user.then((userResult) => {
          if (userResult == null)
            {authentificated = false}
          else
            {
              setState(() {
                authentificated = true;
              })
            },
          print(authentificated),
        });
  }

  @override
  initState() {
    super.initState();
    getuser();
  }

  Widget build(BuildContext context) {
    return authentificated ? BottomNavBar() : SignInScreen();
  }
}
