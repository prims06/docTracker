import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class NotificationApp {
  String? notifictionId;
  final String description;
  final String emitterId;
  final String receiverId;
  final String owner;
  final String documentType;
  final int timestampAsSecond;
  final format = DateFormat('dd-MM-yyyy');
  final format2 = DateFormat('dd.MM.yyyy HH:mm');

  NotificationApp(
      {required this.description,
      required this.receiverId,
      required this.documentType,
      required this.emitterId,
      required this.owner,
      required this.timestampAsSecond,
      required this.notifictionId});

  String formatTimeStamp() {
    return format.format(
        DateTime.fromMillisecondsSinceEpoch(timestampAsSecond * 1000)
            .toLocal());
  }

  String formatTimeStamp2() {
    return format2.format(
        DateTime.fromMillisecondsSinceEpoch(timestampAsSecond * 1000)
            .toLocal());
  }

  Map<String, dynamic> toMap(NotificationApp doc) => {
        'description': doc.description,
        'receiverId': doc.receiverId,
        'documentType': doc.documentType,
        'owner': doc.owner,
        'emitterId': FirebaseAuth.instance.currentUser!.uid,
        'timestampAsSecond': getStamp
      };

  static NotificationApp fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> doc =
        documentSnapshot.data() as Map<String, dynamic>;
    return NotificationApp(
        notifictionId: documentSnapshot.id,
        receiverId: doc["receiverId"],
        documentType: doc["documentType"],
        description: doc["description"],
        emitterId: doc["emitterId"],
        owner: doc["owner"],
        timestampAsSecond: doc["timestampAsSecond"]);
  }

  static List<NotificationApp> fromQuerySnapshot(QuerySnapshot querySnapshot) {
    List<NotificationApp> documents = [];
    for (final doc in querySnapshot.docs) {
      final document = NotificationApp(
          notifictionId: doc.id,
          description: doc["description"],
          documentType: doc["documentType"],
          owner: doc["owner"],
          receiverId: doc["receiverId"],
          emitterId: doc["emitterId"],
          timestampAsSecond: doc["timestampAsSecond"]);
      documents.add(document);
    } // end for
    return documents;
  }
}
