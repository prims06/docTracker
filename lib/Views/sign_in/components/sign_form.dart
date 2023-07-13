import 'package:doc_tracker/Controllers/Firebase/Auth.dart';
import 'package:doc_tracker/Views/nav-bar.dart';
import 'package:flutter/material.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Models/Widgets/button.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool visible = false;
  bool isLoadingSignIn = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              Row(
                children: [
                  Container(),
                  Spacer(),
                  GestureDetector(
                    onTap: () => {},
                    child: Text(
                      "Forgot Password",
                      style: buttonStyle(ColorApp.secondaryText),
                    ),
                  )
                ],
              ),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                  text: "Continue",
                  press: () async {
                    setState(() {
                      isLoadingSignIn = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      if (_formKey.currentState!.validate()) {
                        final result =
                            await AuthServices.SignInWithEmailAndPassword(
                                '$email@$domainNameService', password);
                        if (result) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => BottomNavBar())));
                        } else {
                          addError(error: unknowError);
                        }

                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        // KeyboardUtil.hideKeyboard(context);
                        // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                      }
                      setState(() {
                        isLoadingSignIn = false;
                      });
                    }
                  }),
            ],
          ),
        ),
        if (isLoadingSignIn)
          Container(
            color: ColorApp.defaultBackgroundColor.withOpacity(0.2),
            height: getSize(context).height,
            child: Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: primaryMain,
                size: 75,
              ),
            ),
          )
      ],
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: !visible,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      cursorColor: primaryMain,
      decoration: inputDecoration(
          'Password', "Enter your password", "assets/icons/Lock.svg",
          press: () {
        setState(() {
          visible = !visible;
        });
      }),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.length == 9) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (value.length != 9) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      cursorColor: primaryMain,
      decoration: inputDecoration(
          "Phone Number", "Enter your phone number", "assets/icons/phone.svg"),
    );
  }
}
