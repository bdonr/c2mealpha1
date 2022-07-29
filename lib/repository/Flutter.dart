import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterRepo {
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getReferenceAndSubCollectionAsStream(
          String id, collectionName, subCollection) {
    return getReferenceAndSubCollection(id, collectionName, subCollection)
        .snapshots();
  }

  static CollectionReference<Map<String, dynamic>> getReferenceAndSubCollection(
      String id, collectionName, subCollection) {
    return getReferenceOFCollection(collectionName)
        .doc(id)
        .collection(subCollection);
  }

  static CollectionReference<Map<String, dynamic>> getReferenceOFCollection(
      collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      getReferenceOFCollectionAsStream(String id, collectionName) {
    return getReferenceOFCollection(collectionName).doc(id).snapshots();
  }
}
