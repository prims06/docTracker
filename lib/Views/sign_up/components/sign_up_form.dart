import 'package:doc_tracker/Controllers/Firebase/Auth.dart';
import 'package:doc_tracker/Models/Widgets/button.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/nav-bar.dart';
import 'package:doc_tracker/Views/otp/otp_screen.dart';
import 'package:doc_tracker/Views/sign_up/components/body.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  String? firstName;
  String? lastName;
  bool visible = false;
  bool isLoadingSignUp = false;
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
              buildFirstNameFormField(),
              SizedBox(height: 30),
              buildSurnameFormField(),
              SizedBox(height: 30),
              buildEmailFormField(),
              SizedBox(height: 30),
              buildPasswordFormField(),
              SizedBox(height: 30),
              buildConformPassFormField(),
              FormError(errors: errors),
              SizedBox(height: 40),
              DefaultButton(
                text: "Continue",
                press: () async {
                  setState(() {
                      isLoadingSignUp = true;
                    });
                  if (_formKey.currentState!.validate()) {
                    final result = await AuthServices.signUpEmailAndPassword(
                        '$email@$domainNameService',
                        password,
                        firstName,
                        lastName,
                        email);
                    if (result) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => BottomNavBar())));
                    } else {
                      addError(error: unknowError);
                    }
                    _formKey.currentState!.save();
                    

                    // if all are valid then go to success screen
                    // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                  }
                  setState(() {
                      isLoadingSignUp = false;
                    });
                },
              ),
            ],
          ),
        ),
      if (isLoadingSignUp)
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: !visible,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      cursorColor: primaryMain,
      decoration: inputDecoration(
        "Confirm Password",
        "Re-enter your password",
        "assets/icons/Lock.svg",
        pass: true,
        press: () {
          setState(() {
            visible = !visible;
          });
        },
      ),
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
        password = value;
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
      keyboardType: TextInputType.visiblePassword,
      cursorColor: primaryMain,
      decoration: inputDecoration(
        "Password",
        "Enter your password",
        "assets/icons/Lock.svg",
        pass: true,
        press: () {
          setState(() {
            visible = !visible;
          });
        },
      ),
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

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
        firstName = value;
       
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kFirstNameNullError);
          return "";
        }
        return null;
      },
      cursorColor: primaryMain,
      decoration: inputDecoration(
          "First Name", "Enter your First Name", "assets/icons/User Icon.svg"),
    );
  }

  TextFormField buildSurnameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSurNameNullError);
        }
       lastName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kSurNameNullError);
          return "";
        }
        return null;
      },
      cursorColor: primaryMain,
      decoration: inputDecoration(
          "Surname", "Enter your Surname", "assets/icons/User Icon.svg"),
    );
  }
}
