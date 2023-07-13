import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Scaffold(
        body: Stack(children: [
      Column(children: [
        Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(label: 'About'.i18n(), context: context)),
      ])
    ]));
  }
}
