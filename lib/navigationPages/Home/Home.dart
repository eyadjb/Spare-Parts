// ignore_for_file: file_names, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_collection_literals, avoid_print, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spareparts/main.dart';
import 'package:spareparts/navigationPages/Home/CardOfPost.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  double avg = 0.1;
  Map<String, dynamic> ratersDict = {};
  bool isLogged = isLoggedIn;
  bool love = true;

  Set<String> favoritePosts = Set();

  User? user = FirebaseAuth.instance.currentUser;

  Future<List<String>> _getImages(String documentId) async {
    List<String> imageUrls = [];
    Reference imagesRef =
        FirebaseStorage.instance.ref().child('images/$documentId');
    try {
      ListResult result = await imagesRef.listAll();
      for (Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      print('Error loading images: $e');
    }
    return imageUrls;
  }

  void showContent(String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWidget(documentId: documentId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Cars').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> cards = [];

          snapshot.data?.docs.forEach((document) {
            String documentId = document.id;
            String email = document['email'];
            String manufacturer = document['manufacturer'];
            String name = document['name'];

            cards.add(
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => showContent(documentId),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 154, 154, 154),
                          Color.fromARGB(255, 231, 230, 236),
                          Color.fromARGB(255, 216, 216, 219),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 2,
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<List<String>>(
                          future: _getImages(documentId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(child: Text('No images found'));
                            } else {
                              return CarouselSlider.builder(
                                itemCount: snapshot.data!.length,
                                options: CarouselOptions(
                                  height: 190.0,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: false,
                                  viewportFraction: 0.9,
                                ),
                                itemBuilder:
                                    (BuildContext context, int index, _) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Image.network(
                                      width: 420,
                                      snapshot.data![index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Manufacturer: $manufacturer'),
                                Text('Name: $name'),
                                Text('Email: $email'),
                                Text('Email: $email'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Manufacturer: $manufacturer'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });

          return ListView(
            children: cards,
          );
        },
      ),
    );
  }
}

// class MyWidget extends StatelessWidget {
//   final String documentId;

//   MyWidget({required this.documentId});

//   @override
//   Widget build(BuildContext context) {
//     // Your custom widget implementation
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details Page'),
//       ),
//       body: Center(
//         child: Text('Document ID: $documentId'),
//       ),
//     );
//   }
// }
