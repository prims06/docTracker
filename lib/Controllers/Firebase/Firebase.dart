import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Firebase {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<DocumentReference<Map<String, dynamic>>> sendDataToFirestore(
          String collectionName, Map<String, dynamic> data) =>
      db.collection(collectionName).add(data);

  static Future<void> updateStatus(String id) async {
    return db
        .collection('documents')
        .doc(id)
        .update({'status': 'REQUESTED'})
        .then((value) => print("successfully updated"))
        .catchError((error) => print("error has occured: $error"));
  }

  static Future<bool> sendData(
      String collectionName, Map<String, dynamic> data) async {
    var result = await db.collection(collectionName).add(data);
    if (result == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<String> uploadImage(XFile image, BuildContext context) async {
    var storage = FirebaseStorage.instance;
    if (image != null) {
      //Upload to Firebase
      var snapshot = await storage
          .ref('documents/' + image.name)
          .putFile(File(image.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      // FirebaseFirestore.instance
      //     .collection('documents')
      //     .doc(id)
      //     .update({'imageUrl': downloadUrl})
      //     .then((value) => {print('Stored................')})
      //     .catchError(() => {print('Error !!!!!!!!!!!!!!!!!!!!!')});
      return downloadUrl;
    } else {
      if (kDebugMode) {
        print('No Image Path Received');
      }
    }
    return '';
  }
}
