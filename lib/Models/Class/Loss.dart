import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DocumentLost {
  final String documentId;
  final String docOwnerName;
  final String documentType;
  final String emitterId;
  final String status;
  final int timestampAsSecond;
  final format = DateFormat('dd-MM-yyyy');
  final format2 = DateFormat('dd.MM.yyyyTHH:mm');

  DocumentLost(
      {required this.docOwnerName,
      required this.documentType,
      required this.emitterId,
      this.status = 'PUBLISHED',
      required this.timestampAsSecond,
      required this.documentId});

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

  Map<String, dynamic> toMap(DocumentLost doc) => {
        'docOwnerName': doc.docOwnerName,
        'documentType': doc.documentType,
        'status': 'PUBLISHED',
        'emitterId': FirebaseAuth.instance.currentUser!.uid,
        'timestampAsSecond': getStamp
  };

  static DocumentLost fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> doc =
        documentSnapshot.data() as Map<String, dynamic>;
    return DocumentLost(
        documentId: documentSnapshot.id,
        docOwnerName: doc["docOwnerName"],
        documentType: doc["documentType"],
        status: doc["status"],
        emitterId: doc["emitterId"],
        timestampAsSecond: doc["timestampAsSecond"]);
  }

  static List<DocumentLost> fromQuerySnapshot(QuerySnapshot querySnapshot) {
    List<DocumentLost> documents = [];
    for (final doc in querySnapshot.docs) {
      final document = DocumentLost(
          documentId: doc.id,
          docOwnerName: doc["docOwnerName"],
          documentType: doc["documentType"],
          status: doc["status"],
          emitterId: doc["emitterId"],
          timestampAsSecond: doc["timestampAsSecond"]);
      documents.add(document);
    } // end for
    return documents;
  }
}
