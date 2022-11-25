import 'package:firebase/details_page.dart';
import 'package:firebase/firebase_operation.dart';
import 'package:firebase/homepage.dart';
import 'package:firebase/model_class.dart';
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
      home: NewPage(),
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
          children: [
            Expanded(
              child: Container(
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return CircularProgressIndicator();
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
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black),),
                                                  Text("${data['name']}"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("Age: ", style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black),),
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
                                            icon: Icon(Icons.delete), color: Colors.red,)
                                      ],
                                    )),
                                Divider(height: 1, thickness: 1,)
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
                          User newUser = new User(
                              name: nameController.text,
                              age: ageController.text);
                          //var ref = FireStoreController.generateID();
                          var ref = FireStoreController.uploadingData(
                              newUser.toMap());
                          print(ref);
                          nameController.text ="";
                          ageController.text="" ;
                        }
                      },
                    )
                  ],
                )),
          ],
        ));
  }
}
