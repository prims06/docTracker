import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Column(
      children: List.generate(errors.length,
          (index) => formErrorText(context, error: errors[index]!)),
    );
  }

  Row formErrorText(context, {required String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: getProportionateScreenWidth(14),
          width: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          error,
          style: bodyLightStyle(ColorApp.secondaryText),
        ),
      ],
    );
  }
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your phone number";
const String kFirstNameNullError = "Please Enter your first name";
const String kSurNameNullError = "Please Enter your Surname";
const String kInvalidEmailError = "Please Enter Valid Phone Number";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String unknowError = "Authentification failed ! Please retry";
const String domainNameService = "tracker.cm";

otpInputDecoration(BuildContext context) => InputDecoration(
      contentPadding:
          EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
      border: outlineInputBorder(context),
      focusedBorder: outlineInputBorder(context),
      enabledBorder: outlineInputBorder(context),
    );

OutlineInputBorder outlineInputBorder(BuildContext context) {
  ColorApp().init(context);
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: ColorApp.primaryText),
  );
}

class SocalCard extends StatelessWidget {
  const SocalCard({
    Key? key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(18),
      ),
    );
  }
}

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: bodyLightStyle(ColorApp.secondaryText),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUpScreen()))
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16), color: primaryMain),
          ),
        ),
      ],
    );
  }
}

InputDecoration inputDecoration(label, hint, icon,
        {pass = false, void Function()? press}) =>
    InputDecoration(
      contentPadding: EdgeInsets.only(left: 12, bottom: 8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: primaryMain,
            width: 1,
          )),
      focusColor: primaryMain,
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: errorMain,
            width: 1,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: primaryMain,
            width: 1,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: errorMain,
            width: 1,
          )),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: pass
          ? GestureDetector(
              onTap: press, child: CustomSurffixIcon(svgIcon: icon))
          : CustomSurffixIcon(svgIcon: icon),
      // hintText: 'Entrez le nom ici',
      labelText: label,
      hintText: hint,
      labelStyle: bodyLightStyle(ColorApp.secondaryText),
      hintStyle: bodyLightStyle(ColorApp.secondaryText),
    );
