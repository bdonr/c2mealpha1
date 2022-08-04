import 'package:c2mealpha1/repository/CollectionEnum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterRepo {
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getReferenceAndSubCollectionAsStream(
          String id, CollectionEnum collectionName, CollectionEnum subCollection) {
    return getReferenceAndSubCollection(id, collectionName, subCollection)
        .snapshots();
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>>
  getReferenceAndSubCollectionOrderedAsStream(
      String id, CollectionEnum collectionName, CollectionEnum subCollection,String orderBy,bool asc) {
    return getReferenceAndSubCollection(id, collectionName, subCollection).orderBy(orderBy, descending: asc)
        .snapshots();
  }


  static CollectionReference<Map<String, dynamic>> getReferenceAndSubCollection(
      String id, CollectionEnum collectionName, CollectionEnum subCollection) {
    return getReferenceOFCollection(collectionName)
        .doc(id)
        .collection(subCollection.name);
  }

  static CollectionReference<Map<String, dynamic>> getReferenceOFCollection(
      CollectionEnum collectionName) {
    return FirebaseFirestore.instance.collection(collectionName.name);
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      getReferenceOFCollectionAsStream(String id, CollectionEnum collectionName) {
    return getReferenceOFCollection(collectionName).doc(id).snapshots();
  }

  static Future<DocumentSnapshot<Object?>> getDocSnapOfString(String id) async{
    return await FirebaseFirestore.instance.doc(id).get();
  }
}
