import 'package:doc_tracker/Models/Class/Document.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DocumentCard extends StatelessWidget {
  DocumentCard({required this.doc});
  final Document doc;

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Container(
        height: 200,
        margin: paddingSymetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
            color: ColorApp.defaultBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [boxShadow(context)]),
        // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
        child: Container(
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.orange.withAlpha(40),
                        ),
                        Image.asset('assets/images/order.png')
                      ],
                    ),
                  ),
                  // SizedBox(height: 5),
                  Text(
                    doc.docOwnerName.toLowerCase().toTitleCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: bodyStyle(ColorApp.primaryText, fontSize: 20),
                  ),
                  Text(
                    doc.documentType.i18n(),
                    style: bodyLightStyle(primaryMain),
                  ),
                  Text(
                    doc.formatTimeStamp(),
                    style: footnoteStyle(ColorApp.secondaryText),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
