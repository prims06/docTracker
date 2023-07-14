import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Controllers/Firebase/Firebase.dart';
import 'package:doc_tracker/Models/Class/Notification.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/announce.dart';
import 'package:doc_tracker/Views/documents.dart';
import 'package:doc_tracker/Views/losses-screen.dart';
import 'package:doc_tracker/Views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar();
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

Future<List<NotificationApp>> getNotifs() async {
  QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
      .collection('notifications')
      .where("emitterId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy('timestampAsSecond', descending: true)
      .get();
  QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
      .collection('notifications')
      .where("receiverId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy('timestampAsSecond', descending: true)
      .get();

  var listNotifs = NotificationApp.fromQuerySnapshot(querySnapshot1) +
      NotificationApp.fromQuerySnapshot(querySnapshot2);
  listNotifs
      .sort(((a, b) => a.timestampAsSecond.compareTo(b.timestampAsSecond)));
  return listNotifs;
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedItem = 0;
  bool internet = false;

  List<Widget> page = [
    DocumentsScreen(),
    DocumentsLostScreen(),
    MakeAnnouncePage(),
    ProfileScreen(),
  ];

  getNotifications() async {
    print('notifs debut');
    print(notifs);
    notifs = await getNotifs();
    print('notifs fin');
    print(notifs);
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotifications();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    var size = MediaQuery.of(context).size;
    return Material(
        child: Scaffold(
            // backgroundColor: primaryMain,
            bottomNavigationBar: CustomBottomNavigationBar(
              onChange: (val) {
                setState(() {
                  _selectedItem = val;
                });
              },
              defaultSelectedIndex: 0,
              iconList: [],
            ),
            body: page[_selectedItem]));

    // }
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {Key? key,
      this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  final List<String> svgIcons = [
    "assets/icons/id-card.svg",
    "assets/icons/carnet.svg",
    "assets/icons/add.svg",
    "assets/icons/user.svg"
  ];
  List<String> _iconList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = svgIcons;
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }
    BoxShadow _boxSH() {
      ColorApp().init(context);
      return BoxShadow(
        color: Colors.black.withOpacity(.4),
        blurRadius: 9,
        spreadRadius: 4,
        offset: Offset(-10, 1),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: ColorApp.defaultBackgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [boxShadow(context)],
      ),
      child: Row(
        children: _navBarItemList,
      ),
    );
  }

  Widget buildNavBarItem(String icon, int index) {
    ColorApp().init(context);
    return InkWell(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / _iconList.length,
        // decoration: index == _selectedIndex
        //     ? BoxDecoration(
        //         border: Border(top: BorderSide(width: 2, color: primaryMain)),
        //         // borderRadius:
        //         //     index == 0 || index == 3 ? BorderRadius.zero : null,
        //       )
        //     : null,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    // height: 28,
                    color: index == _selectedIndex
                        ? primaryMain
                        : ColorApp.blackWhiteColor,
                  ),
                ),
              ),
              Spacer(),
              (index == 0)
                  ? Text(
                      'Founds'.i18n(),
                      style: overlineStyle(index == _selectedIndex
                          ? primaryMain
                          : ColorApp.secondaryText),
                    )
                  : SizedBox(),
              index == 1
                  ? Text(
                      'Losses'.i18n(),
                      style: overlineStyle(index == _selectedIndex
                          ? primaryMain
                          : ColorApp.secondaryText),
                    )
                  : SizedBox(),
              index == 2
                  ? Text(
                      'Announce'.i18n(),
                      style: overlineStyle(index == _selectedIndex
                          ? primaryMain
                          : ColorApp.secondaryText),
                    )
                  : SizedBox(),
              // index == 3
              //     ? Text(
              //         'dashboard_text'.i18n(),
              //         style: overlineStyle(index == _selectedIndex
              //             ? primaryMain
              //             : ColorApp.secondaryText),
              //       )
              //     : SizedBox(),
              index == 3
                  ? Text(
                      'Profile'.i18n(),
                      style: overlineStyle(index == _selectedIndex
                          ? primaryMain
                          : ColorApp.secondaryText),
                    )
                  : SizedBox(),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
