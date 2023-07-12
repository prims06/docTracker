import 'dart:convert';

import 'package:doc_tracker/Controllers/Firebase/Firebase.dart';
import 'package:doc_tracker/Models/Class/Document.dart';
import 'package:doc_tracker/Models/Class/data.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/image_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

class DocumentDetailScreen extends StatefulWidget {
  DocumentDetailScreen({super.key, required this.document});
  Document document;

  @override
  _DocumentDetailScreenState createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends State<DocumentDetailScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  bool whatsapp = false;
  File? image;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: Curves.easeInToLinear));
    Category categorie = AppData.categoryList
        .where((element) => element.fieldName == widget.document.documentType)
        .toList()[0];
    categories = [
      categorie,
      ...AppData.categoryList
          .where((element) => element.fieldName != widget.document.documentType)
          .toList()
    ];
    print(widget.document.imageUrl);
    urlToFile(widget.document.imageUrl);
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();

    super.dispose();
  }

  Future<void> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    setState(() {
      image = file;
    });
  }

  List<Category> categories = [];

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: paddingAll(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          customIconButton(context,
            icon: Icons.arrow_back_ios,
            press: () {
              Navigator.of(context).pop();
            },
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: paddingAll(10),
              decoration: BoxDecoration(
                  borderRadius: circularBorder,
                  color: ColorApp.defaultBackgroundColor,
                  boxShadow:[boxShadow(context)]),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Signaler',
                    style: bodyLightStyle(ColorApp.primaryText),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation!.value,
          child: child,
        );
      },
      animation: animation!,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // widget.document.imageUrl == null
          //     ? Image.asset('assets/images/pattern_success.png')
          //     :
          Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: primaryMain,
              size: 75,
            ),
          ),
          image != null
              ? GestureDetector(
                  child: Image.file(image!),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageScreen(image: image!)));
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _thumbnail(String image) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation!.value,
        duration: Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(13)),
              // color: Theme.of(context).backgroundColor,
            ),
            child: Image.asset(image),
          )),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          // margin: paddingAll(24),
          padding: paddingSymetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: ColorApp.defaultBackgroundColor),
          child: SingleChildScrollView(
            controller: scrollController,
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: ColorApp.disabledText.withOpacity(.5),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                alertContainer(
                    context: context,
                    text:
                        'Veuillez vous assurer que ce document soit conforme et ne soit pas juste une tentative d\'arnaque'),
                Text(
                  widget.document.docOwnerName.toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: supertitleStyle(ColorApp.secondaryText),
                ),
                Container(
                  margin: paddingSymetric(vertical: 16),
                  width: getSize(context).width,
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categories
                        .map((e) => CategoryWidget(
                            model: e,
                            isSelected:
                                widget.document.documentType == e.fieldName))
                        .toList(),
                  ),
                ),
                Container(
                  margin: paddingSymetric(vertical: 16),
                  child: Text(
                    "Plublié le ${widget.document.formatTimeStamp2().split('T')[0]} à ${widget.document.formatTimeStamp2().split('T')[1]}",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: footfilterStyle(ColorApp.secondaryText),
                  ),
                ),
                // DateTime.parse(givenDate).toLocal();
                Container(
                  // padding: paddingAll(24),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var whatsappUrl =
                                "whatsapp://send?phone=237${widget.document.finderPhoneNumber}" +
                                    "&text=${Uri.encodeComponent("Bonjour \n Je suis ${widget.document.docOwnerName} \n Je vous écrit à propos du document que vous avez trouvé m'appartenant")}";
                            await launchUrl(Uri.parse(whatsappUrl));
                          },
                          child: Container(
                            padding: paddingOnly(
                                left: 16, top: 10, right: 16, bottom: 10),
                            margin: paddingOnly(right: 16),
                            decoration: BoxDecoration(
                                borderRadius: circularBorder,
                                gradient: kPrimaryGradientColor,
                                color: ColorApp.defaultBackgroundColor,
                                boxShadow:[boxShadow(context)]),
                            child: Icon(
                              Icons.whatsapp,
                              color: white,
                              size: 28,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // Firebase.updateStatus(widget.document.documentId);
                              await launchUrl(Uri.parse(
                                  'tel://+237${widget.document.finderPhoneNumber}'));
                            },
                            child: Container(
                              padding: paddingAll(10),
                              decoration: BoxDecoration(
                                  borderRadius: circularBorder,
                                  border:
                                      Border.all(width: 1, color: primaryMain),
                                  color: ColorApp.defaultBackgroundColor,
                                  boxShadow:[boxShadow(context)]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: primaryMain,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Telephoner',
                                    style: bodyLightStyle(ColorApp.primaryText),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      padding: paddingOnly(top: 8),
                      height: getSize(context).height / 2.23,
                      width: getSize(context).width,
                      child: _productImage()),
                  _appBar(),
                ],
              ),
              _detailWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget CategoryWidget({required Category model, bool isSelected = false}) {
    return Container(
        // height: 70,
        padding: paddingSymetric(vertical: 4, horizontal: 8),
        margin: paddingOnly(
          right: 16,
        ),
        decoration: BoxDecoration(
            borderRadius: circularBorder,
            color: isSelected
                ? ColorApp.defaultBackgroundColor
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? primaryMain : ColorApp.disabledText,
              width: isSelected ? 2 : 1,
            ),
            boxShadow:[boxShadow(context)]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              model.asset,
              color: isSelected ? primaryMain : ColorApp.disabledText,
              // height: 20,
            ),
            Text(model.name,
                style: bodyStyle(isSelected
                    ? ColorApp.secondaryText
                    : ColorApp.disabledText)),
          ],
        ));
  }
}
