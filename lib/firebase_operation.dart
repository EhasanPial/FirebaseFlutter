import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model_class.dart';

class FireStoreController {
  static Future<List<UserModel>> getAllEntries(String collection) async {


    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => UserModel.fromMap(item.data()))
        .toList();
  }
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllEntriesStreamBuilder(String collection) async {
    return FirebaseFirestore.instance
        .collection("UserModels")
        .snapshots();
  }

  static DocumentReference<Map<String, dynamic>> generateID() {
    final newCityRef = FirebaseFirestore.instance.collection("UserModels").doc();
    return newCityRef;
  }

  static Future<void> uploadingDataWithID(Map<String, dynamic> data,
      DocumentReference<Map<String, dynamic>> newRef) async {
    await newRef.set(data);
  }

  static Future<void> uploadingData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("UserModels")
        .add(data)
        .then((value) {});
  }

  static Future<void> editProduct(UserModel UserModel, String id) async {
    await FirebaseFirestore.instance
        .collection("UserModels")
        .doc(id)
        .update(UserModel.toMap());
  }

  static Future<void> deleteProduct(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance.collection("UserModels").doc(doc.id).delete();
  }
}
