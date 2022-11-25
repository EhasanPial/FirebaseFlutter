import 'dart:convert';

class UserModel {
  UserModel({required this.name, required this.age});

  final String name;
  final String age;

  /* final Engine? engine;
  final String manufacturer;
  final int price;*/

  factory UserModel.fromJson(String str) =>
      UserModel.fromMap(json.decode(str)); // decode string ke json e convert kore

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map){
    return  UserModel(
      // map theke new UserModel
      name: map["name"],
      age: map["age"],
    );
  }

  Map<String, dynamic> toMap() { // converting to json to store on firebase
    return {
      if (name != null) "name": name,

      if (age != null) "regions": age,
    };
  }

  @override
  String toString() {
    return "${name} : ${age}";
  }
}
