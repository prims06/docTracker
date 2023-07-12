import 'dart:io';

import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key, required this.image});
  final File image;
  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryMain,
        title: Text(
          'Image du document',
          style: titleStyle(ColorApp.primaryText),
        ),
      ),
      body: Center(
        child:
            // Container(
            //   height: getSize(context).height,
            //   width: double.infinity,
            //   child: Stack(
            //     children: [
            Image.file(image),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: customIconButton(icon: Icons.arrow_back_ios),
        // ),
        //   ],
        // ),
        // ),
      ),
    );
  }
}
