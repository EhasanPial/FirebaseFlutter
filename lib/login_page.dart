import 'package:firebase/auth_provider.dart';
import 'package:firebase/homepage.dart';
import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data",
          ),
          centerTitle: true,
          leading: Icon(Icons.menu),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: passController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Sign In'),
                        onPressed: signInWithEmailAndPassword,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      ElevatedButton(
                          onPressed: createUserWithEmailAndPassword,
                          child: Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      CircularNotchedRectangle();
      await Auth().signInWithEmailAndPassword(
          email: nameController.text, password: passController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NewPage()));
    } on FirebaseAuthException catch (e) {
      print(e.toString()) ;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      print(nameController.text + passController.text);
      await Auth().createUserWithEmailAndPassword(
          email: nameController.text, password: passController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NewPage()));
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e);
    }
  }
}
