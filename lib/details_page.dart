import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase_operation.dart';
import 'package:firebase/homepage.dart';
import 'package:firebase/main.dart';
import 'package:firebase/model_class.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DocumentSnapshot data;

  DetailsPage({Key? key, required DocumentSnapshot this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    nameController.text = data['name'] ;
    ageController.text = data['regions'] ;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",

        ),
        centerTitle: true,

        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: ageController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Sign In'),
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      nameController.text.isNotEmpty) {
                    User newUser = new User(
                        name: nameController.text, age: ageController.text);
                    //var ref = FireStoreController.generateID();

                        FireStoreController.editProduct(newUser,data.id);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NewPage())) ;

                  }
                },
              )
            ],
          )),
    );
  }
}
