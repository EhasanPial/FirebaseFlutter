import 'package:firebase/auth_provider.dart';
import 'package:firebase/details_page.dart';
import 'package:firebase/firebase_operation.dart';
import 'package:firebase/login_page.dart';
import 'package:firebase/model_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NewPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final User? user = Auth().currentUser;

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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                await Auth().signOut() ;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())) ;

              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text("User Email: ${user?.email ?? ""}"),
                  Text("User Id: ${user?.uid ?? ""}")
                ],
              ),
            ),
            Expanded(
              child: Container(
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return SizedBox(
                          height: 10,
                          child: CircularProgressIndicator(),
                        );
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];

                          print(data.id);

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(data: data)),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Name: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  Text("${data['name']}"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Age: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  Text("${data['regions']}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(
                                          flex: 3,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            FireStoreController.deleteProduct(
                                                data);
                                          },
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                        )
                                      ],
                                    )),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data?.docs.length,
                      );
                    },
                  )),
            ),
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
                          UserModel newUser = new UserModel(
                              name: nameController.text,
                              age: ageController.text);
                          //var ref = FireStoreController.generateID();
                          var ref = FireStoreController.uploadingData(
                              newUser.toMap());
                          print(ref);
                          nameController.text = "";
                          ageController.text = "";
                        }
                      },
                    )
                  ],
                )),
          ],
        ));
  }
}
