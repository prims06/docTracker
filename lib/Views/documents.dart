import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Models/Class/Document.dart';
import 'package:doc_tracker/Models/Class/data.dart';
import 'package:doc_tracker/Models/Widgets/card.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/announce.dart';
import 'package:doc_tracker/Views/document_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  _DocumentsScreenState();
  List<Document>? Alldocuments;
  List<Document>? Docs;
  bool filtering = false;
  bool autofocus = false;
  String searchInitValue = '';
  CollectionReference documents =
      FirebaseFirestore.instance.collection('documents');

  void docList() async {
    QuerySnapshot querySnapshot = await documents
        .where("status", isNotEqualTo: "BLOCKED")
        .orderBy('status')
        .orderBy('timestampAsSecond', descending: true)
        .get();
    setState(() {
      Docs = Alldocuments = Document.fromQuerySnapshot(querySnapshot);
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
                'Found',
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DocumentDetailScreen(document: Docs![index])));
                  }),
                  child: DocumentCard(doc: Docs![index]))),
        ),
      );
    }

    Widget pageScaffold(Widget search, Widget listElement) => Scaffold(
          body: Container(
            padding: paddingOnly(top: 70, bottom: 0, right: 16, left: 16),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pattern_success.png'),
                    opacity: 0.3,
                    fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customIconButton(context, press: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => MakeAnnouncePage()));
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

    return pageScaffold(
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
            : listView());
  }

  @override
  initState() {
    super.initState();
    docList();
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
