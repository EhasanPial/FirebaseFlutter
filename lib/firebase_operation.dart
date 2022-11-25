import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model_class.dart';

class FireStoreController {
  static Future<List<User>> getAllEntries(String collection) async {


    return (await FirebaseFirestore.instance.collection(collection).get())
        .docs
        .map((item) => User.fromMap(item.data()))
        .toList();
  }
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllEntriesStreamBuilder(String collection) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .snapshots();
  }

  static DocumentReference<Map<String, dynamic>> generateID() {
    final newCityRef = FirebaseFirestore.instance.collection("Users").doc();
    return newCityRef;
  }

  static Future<void> uploadingDataWithID(Map<String, dynamic> data,
      DocumentReference<Map<String, dynamic>> newRef) async {
    await newRef.set(data);
  }

  static Future<void> uploadingData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .add(data)
        .then((value) {});
  }

  static Future<void> editProduct(User user, String id) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .update(user.toMap());
  }

  static Future<void> deleteProduct(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance.collection("Users").doc(doc.id).delete();
  }
}
