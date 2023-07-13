import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Sign In"),
        // ),
        body: Body(),
      ),
    );
  }
}
