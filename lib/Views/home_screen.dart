import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Models/Widgets/button.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/documents.dart';
import 'package:doc_tracker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // themeManager.addListener(themeListener);

    super.initState();
  }

  // @override
  // void dispose() {
  //   themeManager.removeListener(themeListener);
  //   super.dispose();
  // }

  // themeListener() {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  String len = 'Awaiting';

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pattern_success.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 250),
                child: DefaultButton(
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => DocumentsScreen()));
                    print(FirebaseAuth.instance.currentUser!.uid);
                  },
                  text: len,
                )),
            Spacer(),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorApp.bagwhite,
                boxShadow: [
                  BoxShadow(
                    color: ColorApp.shadowColor,
                    blurRadius: 3,
                    offset: Offset(-8, 16),
                  ),
                ],
                borderRadius: circularBorder,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/doc.png',
                    height: 100,
                    width: 70,
                  ),
                  
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
