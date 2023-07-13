import 'package:flutter/material.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Models/Widgets/button.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  Body({required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.09),
              Text(
                "OTP Verification",
                style: supertitleStyle(ColorApp.primaryText),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "We sent your code to +" + phoneNumber,
                style: bodyLightStyle(ColorApp.secondaryText),
              ),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: buttonStyle(primaryClick),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expired in ",
          style: bodyLightStyle(ColorApp.secondaryText),
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: bodyBoldStyle(primaryMain),
          ),
        ),
      ],
    );
  }
}
