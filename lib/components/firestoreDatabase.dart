import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  final String uid;

  FirestoreDatabase(this.uid);

  Future addData({String path, Map<String, dynamic> data}) async {
    final ref = Firestore.instance.document(path);
    await ref.setData(data);
  }
}
