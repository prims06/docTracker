import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_tracker/Models/Widgets/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Document {
  final String documentId;
  final String docOwnerName;
  final String documentType;
  final String emitterId;
  final String imageUrl;
  final int timestampAsSecond;
  final format = DateFormat('dd-MM-yyyy');
  final format2 = DateFormat('dd.MM.yyyyTHH:mm');

  Document(
      {required this.docOwnerName,
      required this.documentType,
      required this.emitterId,
      this.imageUrl = '',
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

  Map<String, dynamic> toMap(Document doc) => {
        'docOwnerName': doc.docOwnerName,
        'documentType': doc.documentType,
        'status': 'PENDING',
        'imageUrl': doc.imageUrl,
        'emitterId': FirebaseAuth.instance.currentUser!.uid,
        'timestampAsSecond': getStamp
  };

  static Document fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> doc =
        documentSnapshot.data() as Map<String, dynamic>;
    return Document(
        documentId: documentSnapshot.id,
        docOwnerName: doc["docOwnerName"],
        documentType: doc["documentType"],
        imageUrl: doc["imageUrl"],
        emitterId: doc["emitterId"],
        timestampAsSecond: doc["timestampAsSecond"]);
  }

  static List<Document> fromQuerySnapshot(QuerySnapshot querySnapshot) {
    List<Document> documents = [];
    for (final doc in querySnapshot.docs) {
      final document = Document(
          documentId: doc.id,
          docOwnerName: doc["docOwnerName"],
          documentType: doc["documentType"],
          imageUrl: doc["imageUrl"],
          emitterId: doc["emitterId"],
          timestampAsSecond: doc["timestampAsSecond"]);
      documents.add(document);
    } // end for
    return documents;
  }
}
