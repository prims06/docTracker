import 'dart:io';

import 'package:doc_tracker/Controllers/Firebase/Firebase.dart';
import 'package:doc_tracker/Models/Class/Document.dart';
import 'package:doc_tracker/Models/Class/Loss.dart';
import 'package:doc_tracker/Models/Class/data.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/nav-bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localization/localization.dart';

class MakeAnnouncePage extends StatefulWidget {
  @override
  _MakeAnnouncePageState createState() => _MakeAnnouncePageState();
}

class _MakeAnnouncePageState extends State<MakeAnnouncePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String firstname = '';
  String surname = '';
  String telephone = '';
  String category = '';
  bool isLoading = false;
  bool isLost = true;
  String errorText = '';

  String get getErrorText {
    print('verifie error');
    if (firstname == '') {
      return 'Veuillez renseigner le nom du proprietaire du document !';
    } else if (category == '') {
      return 'Veuillez choisir le type de document concerné !';
    } else if (surname == '') {
      return 'Veuillez renseigner le prenom du proprietaire du document !';
    } else if (image == null && !isLost) {
      return 'Veuillez renseigner une image du document en votre possession !';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pattern_success.png'),
                    opacity: 0.3,
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                SingleChildScrollView(child: planer()),
                if (isLoading)
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
            )),
      ),
    );
  }

  Widget planer() => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
            ),
            (!isLost)
                ? Container(
                    // padding: paddingAll(24),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              // padding:
                              //     paddingOnly(left: 48, top: 48, right: 48, bottom: 48),
                              height: 120,
                              width: 130,
                              margin: paddingOnly(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: circularBorder,
                                  border: Border.all(
                                      width: 1, color: ColorApp.secondaryText),
                                  boxShadow: [boxShadow(context)]),
                              child: Center(
                                child: image == null
                                    ? SvgPicture.asset(
                                        "assets/icons/camera.svg",
                                        width: 24.0,
                                        color: ColorApp.secondaryText,
                                      )
                                    : Image.file(File(image!.path)),
                              )),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await selectPhoto();
                              },
                              child: Container(
                                height: 50,
                                padding: paddingAll(10),
                                decoration: BoxDecoration(
                                    borderRadius: circularBorder,
                                    border: Border.all(
                                        width: 1, color: primaryMain),
                                    color: ColorApp.defaultBackgroundColor,
                                    boxShadow: [boxShadow(context)]),
                                child: Center(
                                  child: Text(
                                    image == null
                                        ? 'Ajouter une image'
                                        : 'Modifier l\'image',
                                    style: bodyLightStyle(ColorApp.primaryText),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                  ),
            errorText != ''
                ? alertContainer(
                    context: context,
                    icon: Icons.error,
                    color: errorMain,
                    borderColor: errorMain,
                    text: errorText,
                    width: 2)
                : !isLost
                    ? alertContainer(
                        context: context,
                        text:
                            'Veuillez a renseignez les informations conforment a celles du document en votre presence')
                    : alertContainer(
                        context: context,
                        text:
                            'Veuillez a renseignez les informations conforment a celles du document que vous avez perdu'),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: getSize(context).width * .00),
                child: Text(
                  'Infos sur le document',
                  style: bodyBoldStyle(ColorApp.secondaryText),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: getSize(context).width * .04),
              child: IntrinsicHeight(
                child: Container(
                    width: double.infinity,
                    child: Container(
                        decoration: BoxDecoration(
                          color: ColorApp.defaultBackgroundColor,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [boxShadow(context)],
                        ),
                        // padding: EdgeInsets.all(8),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: getSize(context).width * .04,
                            vertical: getSize(context).height * .02,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Nom du titulaire",
                                  style: bodyStyle(ColorApp.secondaryText)),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorApp.fieldColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: TextFormField(
                                  cursorColor: primaryMain,
                                  initialValue: '',
                                  onChanged: ((value) => {surname = value}),
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 12, bottom: 8),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                          color: primaryMain,
                                          width: 1,
                                        )),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                          color: errorMain,
                                          width: 1,
                                        )),
                                    hintText: 'Entrez le nom ici',
                                    hintStyle:
                                        bodyLightStyle(ColorApp.secondaryText),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text("Prenom du titulaire",
                                  style: bodyStyle(ColorApp.secondaryText)),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorApp.fieldColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: TextFormField(
                                  cursorColor: primaryMain,
                                  initialValue: '',
                                  onChanged: ((value) => {firstname = value}),
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 12, bottom: 8),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                          color: primaryMain,
                                          width: 1,
                                        )),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                          color: errorMain,
                                          width: 1,
                                        )),
                                    hintText: 'Entrez le prenom ici',
                                    hintStyle:
                                        bodyLightStyle(ColorApp.secondaryText),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text('Type de document'.i18n(),
                                  style: bodyStyle(ColorApp.secondaryText)),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: getSize(context).width * .02),
                                  child: Container(
                                    height: getSize(context).width * .12,
                                    width: double.infinity,
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        // ignore: dead_code
                                        // border: Border.all(
                                        //     width: 1, color: primaryMain),

                                        color: ColorApp.fieldColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            // barrierColor: primaryMain,
                                            selectedItemHighlightColor:
                                                primaryMain,
                                            focusColor: primaryMain,
                                            autofocus: true,
                                            style: TextStyle(
                                              color: primaryMain,
                                              background: Paint()..color,
                                            ),
                                            dropdownFullScreen: true,
                                            // dropdownWidth: 200,
                                            hint: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text(
                                                category != ''
                                                    ? category
                                                    : 'Type de document',
                                                style: bodyStyle(
                                                    ColorApp.secondaryText),
                                              ),
                                            ),
                                            onMenuStateChange: (val) {
                                              // setState(() {
                                              //   click = val;
                                              // });
                                            },

                                            isExpanded: true,
                                            items: AppData.categoryList
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.name,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          item.name,
                                                          style: bodyStyle(
                                                              ColorApp
                                                                  .secondaryText),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                category = value!;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: ColorApp.secondaryText,
                                            ),
                                            iconSize: 30,
                                            buttonDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: ColorApp.fieldColor,
                                            ),
                                            // buttonElevation: 2,
                                            // itemHeight: 40,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0),
                                            dropdownMaxHeight: 200,
                                            // dropdownWidth: 264,
                                            dropdownPadding:
                                                const EdgeInsets.all(0),
                                            dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: ColorApp
                                                    .defaultBackgroundColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              // const SizedBox(
                              //   height: 24,
                              // ),
                              // Text("Votre numero de telephone",
                              //     style: bodyStyle(ColorApp.secondaryText)),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Container(
                              //   height: 40,
                              //   decoration: BoxDecoration(
                              //     color: ColorApp.fieldColor,
                              //     borderRadius: const BorderRadius.only(
                              //         topRight: Radius.circular(4.0),
                              //         bottomRight: Radius.circular(4.0)),
                              //   ),
                              //   child: IntrinsicHeight(
                              //     child: Row(
                              //       children: [
                              //         Container(
                              //           width: 45,
                              //           child: Center(
                              //             child: Text('+237',
                              //                 style:
                              //                     bodyBoldStyle(primaryMain)),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: TextFormField(
                              //             cursorColor: primaryMain,
                              //             onChanged: ((value) =>
                              //                 {telephone = value}),
                              //             keyboardType: TextInputType.phone,
                              //             decoration: InputDecoration(
                              //               contentPadding: EdgeInsets.only(
                              //                   left: 12, bottom: 8),
                              //               border: InputBorder.none,
                              //               focusedBorder: OutlineInputBorder(
                              //                   borderRadius: const BorderRadius
                              //                           .only(
                              //                       topRight:
                              //                           Radius.circular(4.0),
                              //                       bottomRight:
                              //                           Radius.circular(4.0)),
                              //                   borderSide: BorderSide(
                              //                     color: primaryMain,
                              //                     width: 1,
                              //                   )),
                              //               errorBorder: OutlineInputBorder(
                              //                   borderRadius: BorderRadius.all(
                              //                       Radius.circular(4)),
                              //                   borderSide: BorderSide(
                              //                     color: errorMain,
                              //                     width: 1,
                              //                   )),
                              //               hintText:
                              //                   'Entrez votre contact ici',
                              //               hintStyle: bodyLightStyle(
                              //                   ColorApp.secondaryText),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              Container(
                                margin: paddingSymetric(vertical: 24),
                                height: 40,
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (firstname != '' &&
                                        image != null &&
                                        surname != '' &&
                                        category != '') {
                                      String url = await Firebase.uploadImage(
                                          image!, context);
                                      if (url != '') {
                                        Document doc = Document(
                                            docOwnerName:
                                                surname + ' ' + firstname,
                                            documentType: AppData.categoryList
                                                .where((element) =>
                                                    element.name == category)
                                                .toList()[0]
                                                .fieldName,
                                            emitterId: '',
                                            imageUrl: url,
                                            timestampAsSecond: (DateTime.now()
                                                        .millisecondsSinceEpoch /
                                                    1000)
                                                .round(),
                                            documentId: '');

                                        // Map<String, dynamic> doc = {
                                        //   'docOwnerName':
                                        //       surname + ' ' + firstname,
                                        //   'documentType': AppData.categoryList
                                        //       .where((element) =>
                                        //           element.name == category)
                                        //       .toList()[0]
                                        //       .fieldName,
                                        //   'finderPhoneNumber': telephone,
                                        //   'status': "PUBLISHED",
                                        //   'imageUrl': url,
                                        //   'imageCheckStatus': "PENDING",
                                        //   'timestampAsSecond': (DateTime.now()
                                        //               .millisecondsSinceEpoch /
                                        //           1000)
                                        //       .round(),
                                        // };
                                        bool res = await Firebase.sendData(
                                            'documents', doc.toMap(doc));
                                        print('sendData: $res');
                                        if (res) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBar()));
                                        } else {
                                          setState(() {
                                            errorText =
                                                'Desole une erreur est servenue, Veuillez reessayer plus tard';
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          errorText =
                                              'Desole une erreur est servenue, Veuillez reessayer plus tard';
                                        });
                                      }
                                    } else if(firstname != '' &&
                                        surname != '' &&
                                        category != '' && isLost){
                                        DocumentLost doc = DocumentLost(
                                            docOwnerName:
                                                surname + ' ' + firstname,
                                            documentType: AppData.categoryList
                                                .where((element) =>
                                                    element.name == category)
                                                .toList()[0]
                                                .fieldName,
                                            emitterId: '',
                                            timestampAsSecond: (DateTime.now()
                                                        .millisecondsSinceEpoch /
                                                    1000)
                                                .round(),
                                            documentId: '');
                                       
                                        bool res = await Firebase.sendData(
                                            'losses', doc.toMap(doc));
                                        print('sendData: $res');
                                        if (res) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBar()));
                                        } else {
                                          setState(() {
                                            errorText =
                                                'Desole une erreur est servenue, Veuillez reessayer plus tard';
                                          });
                                        }
                                        } else {
                                      print('data not correct');
                                      setState(() {
                                        errorText = getErrorText;
                                      });
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });

                                    print('-----------' + errorText);
                                    Future.delayed(
                                        Duration(seconds: 3),
                                        () => {
                                              setState(() {
                                                errorText = '';
                                              })
                                            });
                                  },
                                  child: Container(
                                      padding: paddingAll(10),
                                      decoration: BoxDecoration(
                                          borderRadius: circularBorder,
                                          color: primaryMain,
                                          boxShadow: [boxShadow(context)]),
                                      child: Center(
                                        child: Text(
                                          'Publier',
                                          style: bodyLightStyle(
                                              ColorApp.primaryText),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ))),
              ),
            ),
          ],
        ),
      );

  changeProfile({required bool isCamera}) async {
    try {
      setState(() {
        // isStartLoading = true;
      });
      if (isCamera) {
        image = await _picker.pickImage(source: ImageSource.camera);
      } else {
        image = await _picker.pickImage(source: ImageSource.gallery);
      }
      if (image != null) {
        Navigator.pop(context);
        // String? result = await Firebase.uploadImage(
        //     image!, 'widget.document.documentId', context);
        // if (result != null) {
        // Document doc =  Document(
        //     docOwnerName: docOwnerName,
        //     imageUrl: result,
        //     documentType: documentType,
        //     finderPhoneNumber: finderPhoneNumber,
        //     timestampAsSecond: timestampAsSecond,
        //     documentId: documentId);
        // showAlertDialog(
        //     context: context,
        //     title: 'dialog_success'.i18n(),
        //     body: 'profile_upload_text'.i18n());
        // } else {
        // showAlertDialog(
        //     context: context,
        //     title: 'dialog_error'.i18n(),
        //     body: 'error_occured_message'.i18n());
        // }
      } else {
        Navigator.pop(context);
        showAlertDialog(
            context: context,
            title: 'dialog_error'.i18n(),
            body: 'error_occured_message'.i18n());
      }
    } catch (e) {
      print('Error : + $e');

      showAlertDialog(
          context: context,
          title: 'dialog_error'.i18n(),
          body: "${'error_occured_message'.i18n()} $e");
    }
    setState(() {
      // currentUserProfile = currentUserProfile;
      // isStartLoading = false;
    });
  }

  selectPhoto() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorApp.defaultBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 24, left: 24, right: 24, bottom: 8),
                    child: Text(
                      'choose_source_text'.i18n(),
                      textAlign: TextAlign.center,
                      style: subtitleStyle(ColorApp.secondaryText),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeProfile(isCamera: true);
                    },
                    child: Container(
                        height: 56.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorApp.defaultBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [boxShadow(context)],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color: primaryMain,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  boxShadow: [boxShadow(context)],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/camera.svg",
                                    width: 16.0,
                                    color: ColorApp.defaultBackgroundColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, right: 50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'camera_text'.i18n(),
                                      style: bodyStyle(ColorApp.primaryText),
                                    ),
                                    Text(
                                      "Photo",
                                      style:
                                          footnoteStyle(ColorApp.primaryText),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      changeProfile(isCamera: false);
                    },
                    child: Container(
                        height: 56.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorApp.defaultBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [boxShadow(context)],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color: primaryMain,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  boxShadow: [boxShadow(context)],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/gallery.svg",
                                    width: 16.0,
                                    color: ColorApp.fieldColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, right: 50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'gallery_text'.i18n(),
                                      style: bodyStyle(ColorApp.primaryText),
                                    ),
                                    Text(
                                      "Image",
                                      style:
                                          footnoteStyle(ColorApp.primaryText),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          );
        });
  }
}
