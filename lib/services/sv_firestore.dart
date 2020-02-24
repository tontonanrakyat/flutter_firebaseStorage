import 'package:cloud_firestore/cloud_firestore.dart';

class SvFirestore {
  Firestore _firestore = Firestore.instance;

  Future<void> createWithAutoDoc(String col, Map<String, dynamic> data) {
    return _firestore.collection(col).document().setData(data);
  }

  Future<void> createWithCustomDoc(
    String col,
    String doc,
    Map<String, dynamic> data,
    bool isMerge,
  ) {
    return _firestore
        .collection(col)
        .document(doc)
        .setData(data, merge: isMerge);
  }

  Future<DocumentSnapshot> read(String col, String doc) {
    return _firestore.collection(col).document(doc).get();
  }

  Future<QuerySnapshot> readAllDoc(String col) {
    return _firestore.collection(col).getDocuments();
  }

  Stream<QuerySnapshot> streamAllDoc(String col) {
    return _firestore.collection(col).snapshots();
  }

  Future<void> update(String col, String doc, String field, String fieldX) {
    return _firestore.collection(col).document(doc).updateData({field: fieldX});
  }

  Future<void> delete(String col, String doc) {
    return _firestore.collection(col).document(doc).delete();
  }
}
