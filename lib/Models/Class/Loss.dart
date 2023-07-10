import 'package:cloud_firestore/cloud_firestore.dart';

class Lost {
  Lost(
      {required this.type,
      required this.completeName,
      required this.telephone});

  Lost.fromJson(Map<String, Object?> json)
      : this(
          type: json['type']! as String,
          completeName: json['completeName']! as String,
          telephone: json['telephone']! as int,
        );

  final String type;
  final String completeName;
  final int telephone;

  Map<String, Object?> toJson() {
    return {
      'type': type,
      'completeName': completeName,
      'telephone': telephone,
    };
  }

  static Lost fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> doc =
        documentSnapshot.data() as Map<String, dynamic>;
    return Lost(
        // documentId: documentSnapshot.id,
        completeName: doc["completeName"],
        type: doc["type"],
        telephone: doc["telephone"]);
  }

  // Lost lostDocument;
  Future<void> addUser(Lost lostDocument) {
    CollectionReference lostCollection =
        FirebaseFirestore.instance.collection('loses');
    // Call the user's CollectionReference to add a new user
    return lostCollection
        .add({
          lostDocument.toJson(),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}