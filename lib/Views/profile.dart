import 'package:doc_tracker/Controllers/Firebase/Auth.dart';
import 'package:doc_tracker/Controllers/Firebase/Firebase.dart';
import 'package:doc_tracker/Models/Class/Notification.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/about.dart';
import 'package:doc_tracker/Views/notifications.dart';
import 'package:doc_tracker/Views/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

List<NotificationApp> notifs = [];

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // finishMasterRoute = false;
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Scaffold(
        backgroundColor: ColorApp.defaultBackgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () => {},
              ),
              ProfileMenu(
                text: "Notifications",
                icon: "assets/icons/Bell.svg",
                isNotif: true,
                press: () {
                  navigate(
                      context,
                      NotificationScreen(
                        list: notifs,
                      ));
                },
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "About",
                icon: "assets/icons/Question mark.svg",
                press: () {
                  navigate(context, AboutScreen());
                },
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () {
                  AuthServices.signOut()
                      .then((value) => navigate(context, SignInScreen()));
                },
              ),
            ],
          ),
        ));
  }
}

Widget ProfileMenu(
    {required text, required icon, required press, isNotif = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: primaryMain,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: ColorApp.shadowColor,
      ),
      onPressed: press,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: primaryMain,
            width: 22,
          ),
          SizedBox(width: 20),
          Expanded(
              child: Text(
            text,
            style: bodyBoldStyle(ColorApp.primaryText),
          )),
          Stack(
            children: [
              Icon(Icons.arrow_forward_ios),
              if (isNotif && notifs.length > 0)
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: errorMain),
                    ))
            ],
          ),
        ],
      ),
    ),
  );
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.person,
              size: 80,
            ),
            // backgroundImage: AssetImage("assets/images/order.png"),
          ),
        ],
      ),
    );
  }
}
