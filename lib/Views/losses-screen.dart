import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Controllers/Firebase/Firebase.dart';
import 'package:doc_tracker/Models/Class/Loss.dart';
import 'package:doc_tracker/Models/Class/Notification.dart';
import 'package:doc_tracker/Models/Class/data.dart';
import 'package:doc_tracker/Models/Widgets/button.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:doc_tracker/Models/Widgets/document-lost.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/announce.dart';
import 'package:doc_tracker/Views/document_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DocumentsLostScreen extends StatefulWidget {
  const DocumentsLostScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsLostScreen> createState() => _DocumentsLostScreenState();
}

class _DocumentsLostScreenState extends State<DocumentsLostScreen> {
  _DocumentsLostScreenState();
  List<DocumentLost>? Alldocuments;
  List<DocumentLost>? Docs;
  bool filtering = false;
  bool autofocus = false;
  bool isBottomSheet = false;
  String searchInitValue = '';
  List<Category> categories = [];
  CollectionReference documents =
      FirebaseFirestore.instance.collection('losses');

  void docList() async {
    QuerySnapshot querySnapshot = await documents
        .where("status", isNotEqualTo: "BLOCKED")
        .orderBy('status')
        .orderBy('timestampAsSecond', descending: true)
        .get();
    setState(() {
      Docs = Alldocuments = DocumentLost.fromQuerySnapshot(querySnapshot);
      selectedDoc = Docs![0];
    });
  }

  filterDocs() {
    setState(() {
      Docs = Alldocuments!
          .where((element) => element.documentType
              .toLowerCase()
              .trim()
              .contains(AppData.categoryList[selectedTabId - 1].fieldName
                  .toLowerCase()
                  .trim()))
          .toList();
    });
    print(AppData.categoryList[selectedTabId - 1].name.toLowerCase().trim());
  }

  int selectedTabId = 0;
  DocumentLost? selectedDoc;
  @override
  initState() {
    super.initState();

    docList();
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);

    Widget UpPage = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lost',
                style: bodyLightStyle(ColorApp.primaryText, fontSize: 30),
              ),
              Text(
                'Documents',
                style: bodyBoldStyle(ColorApp.primaryText, fontSize: 30),
              )
            ]),
        space,
        search(),
        space,
        Container(
          margin: paddingSymetric(vertical: 16),
          width: getSize(context).width,
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: AppData.categoryList
                .map((e) =>
                    CategoryWidget(model: e, isSelected: selectedTabId == e.id))
                .toList(),
          ),
        ),
      ],
    );

    Widget listView() {
      return Expanded(
        child: GridView.count(
          padding: EdgeInsets.zero,
          childAspectRatio: 0.75,
          crossAxisCount: 2,
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              Docs!.length,
              (index) => InkWell(
                  onTap: (() {
                    setState(() {
                      selectedDoc = Docs![index];
                      Category categorie = AppData.categoryList
                          .where((element) =>
                              element.fieldName == selectedDoc!.documentType)
                          .toList()[0];
                      categories = [
                        categorie,
                        ...AppData.categoryList
                            .where((element) =>
                                element.fieldName != selectedDoc!.documentType)
                            .toList()
                      ];
                      isBottomSheet = true;
                    });
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         DocumentDetailScreen(document: Docs![index])));
                  }),
                  child: DocumentLostCard(doc: Docs![index]))),
        ),
      );
    }

    Widget pageScaffold(Widget search, Widget listElement) => Scaffold(
          bottomSheet: (selectedDoc == null || !isBottomSheet)
              ? SizedBox()
              : _detailWidget(doc: selectedDoc!),
          body: Container(
            padding: paddingOnly(top: 70, bottom: 0, right: 16, left: 16),
            
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customIconButton(context, press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MakeAnnouncePage()));
                      }, icon: Icons.sort),
                      customIconButton(context,
                          press: () {}, icon: Icons.person)
                    ],
                  ),
                  Container(padding: const EdgeInsets.all(10.0)),
                  search,
                  listElement
                ]),
          ),
        );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          isBottomSheet = false;
        });
      },
      child: pageScaffold(
          UpPage,
          Docs == null
              ? SizedBox(
                  height: getSize(context).height / 2.5,
                  child: Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: primaryMain,
                      size: 75,
                    ),
                  ),
                )
              : listView()),
    );
  }

  Widget _detailWidget({required DocumentLost doc}) {
    return Container(
      height: getSize(context).height / 2.2,
      child: DraggableScrollableSheet(
        maxChildSize: 1,
        initialChildSize: 1,
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
                          'Veuillez vous assurer que ce document contient les bonnes informations avant d\'engager une action quelconque'),
                  Text(
                    doc.docOwnerName.toUpperCase(),
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
                              isSelected: doc.documentType == e.fieldName))
                          .toList(),
                    ),
                  ),
                  Container(
                    margin: paddingSymetric(vertical: 16),
                    child: Text(
                      "Plublié le ${doc.formatTimeStamp2().split('T')[0]} à ${doc.formatTimeStamp2().split('T')[1]}",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: footfilterStyle(ColorApp.secondaryText),
                    ),
                  ),
                  // DateTime.parse(givenDate).toLocal();
                  // Container(
                  //   // padding: paddingAll(24),
                  //   child: IntrinsicHeight(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () async {
                  //             // var whatsappUrl =
                  //             //     "whatsapp://send?phone=237${doc.finderPhoneNumber}" +
                  //             //         "&text=${Uri.encodeComponent("Bonjour \n Je suis ${doc.docOwnerName} \n Je vous écrit à propos du document que vous avez trouvé m'appartenant")}";
                  //             // await launchUrl(Uri.parse(whatsappUrl));
                  //           },
                  //           child: Container(
                  //             padding: paddingOnly(
                  //                 left: 16, top: 10, right: 16, bottom: 10),
                  //             margin: paddingOnly(right: 16),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: circularBorder,
                  //                 gradient: kPrimaryGradientColor,
                  //                 color: ColorApp.defaultBackgroundColor,
                  //                 boxShadow: [boxShadow(context)]),
                  //             child: Icon(
                  //               Icons.whatsapp,
                  //               color: white,
                  //               size: 28,
                  //             ),
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: GestureDetector(
                  //             onTap: () async {
                  // NotificationApp not = NotificationApp(
                  //     description:
                  //         'init_request_for_get_back_by_loster',
                  //     receiverId: doc.emitterId,
                  //     documentType: doc.documentType,
                  //     emitterId: '',
                  //     owner: doc.docOwnerName,
                  //     timestampAsSecond: getStamp,
                  //     notifictionId: '');
                  // Firebase.sendData(
                  //     'notifications', not.toMap(not));
                  //               // Firebase.updateStatus(doc.documentId);
                  //               // await launchUrl(Uri.parse(
                  //               // 'tel://+237${doc.finderPhoneNumber}'));
                  //             },
                  //             child: Container(
                  //               padding: paddingAll(10),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: circularBorder,
                  //                   border:
                  //                       Border.all(width: 1, color: primaryMain),
                  //                   color: ColorApp.defaultBackgroundColor,
                  //                   boxShadow: [boxShadow(context)]),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.phone,
                  //                     color: primaryMain,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Text(
                  //                     'Telephoner',
                  //                     style: bodyLightStyle(ColorApp.primaryText),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  DefaultButton(
                    text: 'J\'ai trouvé ce document',
                    press: () {
                      NotificationApp not = NotificationApp(
                          description: 'init_request_for_get_back_by_founder',
                          receiverId: doc.emitterId,
                          documentType: doc.documentType,
                          emitterId: '',
                          owner: doc.docOwnerName,
                          timestampAsSecond: getStamp,
                          notifictionId: '');
                      Firebase.sendData('notifications', not.toMap(not));
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget search() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              padding: paddingOnly(top: 8),
              decoration: BoxDecoration(
                  color: ColorApp.fieldColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: TextField(
                  cursorColor: primaryMain,
                  onChanged: (value) {
                    setState(() {
                      Docs = Alldocuments!
                          .where((element) => element.docOwnerName
                              .toLowerCase()
                              .trim()
                              .contains(value.toLowerCase().trim()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Documents",
                      hintStyle: footfilterStyle(ColorApp.secondaryText),
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 0, top: 5),
                      prefixIcon:
                          Icon(Icons.search, color: ColorApp.secondaryText)),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          customIconButton(context, press: () {}, icon: Icons.filter_list)
        ],
      ),
    );
  }

  Widget CategoryWidget({required Category model, bool isSelected = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedTabId = 0;
            Docs = Alldocuments;
          } else {
            selectedTabId = model.id;
          }
          if (selectedTabId != 0) {
            filterDocs();
          }
        });
      },
      child: Container(
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
                color: isSelected ? primaryMain : Colors.grey,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [boxShadow(context)]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                model.asset,
                color: ColorApp.blackWhiteColor,
                // height: 20,
              ),
              Text(model.name, style: bodyStyle(ColorApp.secondaryText)),
            ],
          )),
    );
  }
}
