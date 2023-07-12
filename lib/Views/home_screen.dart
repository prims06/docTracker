import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Models/Class/Document.dart';
import 'package:doc_tracker/Models/Widgets/button.dart';
import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:doc_tracker/Views/documents.dart';
import 'package:doc_tracker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getUrl(String id) async {
    try {
      var storage = FirebaseStorage.instance;

      return await storage.ref("documents/$id").getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  final File file = File('./../Models/urls.json');

  List<Document> Docs = [];
  CollectionReference documents =
      FirebaseFirestore.instance.collection('documents');
  void docList() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    QuerySnapshot querySnapshot = await documents
        .where("status", isNotEqualTo: "BLOCKED")
        .orderBy('status')
        .orderBy('timestampAsSecond', descending: true)
        .get();

    Docs = Document.fromQuerySnapshot(querySnapshot);
    await getAll(Docs);
    // var whatsappUrl = "whatsapp://send?phone=237658359950" +
    //     "&text=${Uri.encodeComponent(result)}";
    // await launchUrl(Uri.parse(whatsappUrl));
  }

  Future<void> getAll(List<Document> Docs) async {
    int j = 0;
    int i = 0;
    for (j; j < Docs.length; j) {
      List<Map<String, String>> list = [];
      for (i = 0; i < 30 && i + j < Docs.length; i++) {
        var url = await getUrl(Docs[i + j].documentId);
        if (url != '') {
          list.add({
            'imageUrl': url,
            'docId': Docs[i + j].documentId,
            'id': (j + i).toString()
          });
          print('Element $i added $url');
        }
      }

      print('lunch $i  $j');
      var whatsappUrl = "whatsapp://send?phone=237658359950" +
          "&text=${Uri.encodeComponent(jsonEncode(list))}";
      await launchUrl(Uri.parse(whatsappUrl));
      j += i;
    }
  }

  @override
  void initState() {
    // themeManager.addListener(themeListener);
    // docList();
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
      body: Container(),
    );
  }
}
