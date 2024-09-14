// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spareparts/navigationPages/Home/CardOfPost.dart';

class Posts extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Posts> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('פרסומות שלי'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Cars')
              .where('Uid', isEqualTo: user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            List<Widget> cards = [];

            snapshot.data?.docs.forEach((document) {
              String documentId = document.id;
              String email = document['email'];
              String manufacturer = document['manufacturer'];
              String PhoneNum = document['NumberOfUser'];
              String types = document['types'];
              String Dates = document['Dates'];

              Timestamp? createdAtTimestamp = document['createdAt'];
              String formattedDate = 'Date not available'; // Default value

              if (createdAtTimestamp != null) {
                DateTime createdAt = createdAtTimestamp.toDate();
                formattedDate =
                    "${createdAt.day}-${createdAt.month}-${createdAt.year}";
              }

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
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(' תאירך פרסום : $formattedDate',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.all(16.0),
                                      height: 130,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Center(
                                              child: Text('Update'),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection('Cars')
                                                    .doc(documentId)
                                                    .delete();
                                              } catch (e) {
                                                print(
                                                    'Error deleting document: $e');
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.more_vert)),
                          FutureBuilder<List<String>>(
                            future: _getImages(documentId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 16 / 9,
                                    enableInfiniteScroll: false,
                                    viewportFraction: 0.9,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index, _) {
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          snapshot.data![index],
                                          fit: BoxFit.fill,
                                          height: 200,
                                          width: double.infinity,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('$types , ',
                                        style: TextStyle(fontSize: 18)),
                                    Text('יצרן רכב: $manufacturer',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('שנת יצור: $Dates',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(' $email',
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(width: 2),
                                    Text(':כתובת אימייל',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('מספר נייד :  $PhoneNum',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
