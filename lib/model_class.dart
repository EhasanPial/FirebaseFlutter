import 'dart:convert';

class User {
  User({required this.name, required this.age});

  final String name;
  final String age;

  /* final Engine? engine;
  final String manufacturer;
  final int price;*/

  factory User.fromJson(String str) =>
      User.fromMap(json.decode(str)); // decode string ke json e convert kore

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> map){
    return  User(
      // map theke new User
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
