import 'package:doc_tracker/Models/Class/Notification.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({required this.list});
  final List<NotificationApp> list;
  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Scaffold(
        body: Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: Container(
          // height: double.infinity,
          padding: paddingAll(24),
          child: SingleChildScrollView(
              child: Column(
            children: list
                .map((e) => buildNotifView(e.description, e.formatTimeStamp2()))
                .toList(),
          )),
        ),
      ),
      Align(
          alignment: Alignment.topCenter,
          child: CustomAppBar(label: 'Notifications'.i18n(), context: context))
    ]));
  }

  Widget buildNotifView(text, date) => Container(
        padding: paddingOnly(top: 16),
        child: Column(children: [
          Text(
            text,
            style: bodyLightStyle(ColorApp.secondaryText),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(),
              Spacer(),
              Text(date, style: footnoteStyle(primaryMain))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(height: 1, color: ColorApp.disabledText),
        ]),
      );
}
