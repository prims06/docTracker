import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("OTP Verification"),
      // ),
      body: Body(),
    );
  }
}