import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Firebase {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<DocumentReference<Map<String, dynamic>>> sendDataToFirestore(
          String collectionName, Map<String, dynamic> data) =>
      db.collection(collectionName).add(data);

      static Future<void> updateStatus(String id) async {
    return FirebaseFirestore.instance
        .collection('documents')
        .doc(id)
        .update({'status': 'REQUESTED'})
        .then((value) => print("successfully updated"))
        .catchError((error) => print("error has occured: $error"));
  }

}
