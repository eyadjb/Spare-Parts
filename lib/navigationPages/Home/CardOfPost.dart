// ignore_for_file: unnecessary_import, file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_print, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  final String documentId;

  MyWidget({
    required this.documentId,
  });

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Cars')
            .where('documentId', isEqualTo: widget.documentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('No data found');
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data?.docs.isEmpty ?? true) {
            print('No cars found');
            return Center(child: Text('No cars found.'));
          }

          List<Widget> cards = [];

          snapshot.data?.docs.forEach((document) {
            String documentId = document.id;
            String email = document['email'];
            String manufacturer = document['manufacturer'];
            String Price = document['Price'];
            String Locations = document['Locations'];
            String PhoneNum = document['NumberOfUser'];
            String Description = document['_controller'];
            String typeofparts = document['typeofparts'];
            String types = document['types'];
            String ifused = document['ifused'];

            cards.add(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CarouselSlider.builder(
                                    itemCount: snapshot.data!.length,
                                    options: CarouselOptions(
                                      height: 200.0,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: true,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index, _) {
                                      return Image.network(
                                        snapshot.data![index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.grey[300]),
                          Text(
                            'פרטי רכב',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          // Divider(color: Colors.grey[300]),
                          Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 17,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '$types ,',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            'יצרן: $manufacturer  ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(Icons.directions_car),
                                        ],
                                      ),
                                    ),
                                    // Row(children: [
                                    //   Expanded(
                                    //     child: _buildInfoRow(null, '', types),
                                    //   ),
                                    //   SizedBox(
                                    //     width: 0,
                                    //   ),
                                    //   Expanded(
                                    //     child: _buildInfoRow(
                                    //         Icons.directions_car,
                                    //         'יצרן :',
                                    //         manufacturer),
                                    //   ),
                                    // ]),
                                    //
                                    //
                                    //
                                    //
                                    //
                                    //
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '$typeofparts ',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            ': סוג החלק',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          Icon(Icons.build_circle_outlined),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),

                                    // _buildInfoRow(Icons.build_circle_outlined,
                                    //     'סוג חלק: ', typeofparts),
                                    _buildInfoRow(Icons.new_releases_outlined,
                                        'מצב החלק : ', ifused),
                                    _buildInfoRow(
                                        Icons.attach_money, 'מחיר:', Price),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(color: Colors.grey[300]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'פרטי מוכר',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              _buildInfoRow(
                                  Icons.location_on, 'מיקום:', Locations),
                              _buildInfoRow(Icons.phone, 'נייד:', PhoneNum),
                              _buildInfoRow(Icons.email, email, ':אימייל'),
                              Divider(color: Colors.grey[300]),
                              Text(
                                'פרטים נוספים',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              // Text(
                              //   ': תיאור',
                              //   style: TextStyle(
                              //       fontSize: 18, color: Colors.black54),
                              // ),
                              // _buildInfoRow(null, '', Description),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(': תיאור',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                    textDirection: TextDirection.ltr),
                              ]),
                          _buildInfoRow(null, '', Description),
                        ],
                      ),
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

  Widget _buildInfoRow(IconData? icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      child: Row(
        textDirection: TextDirection.rtl, // Right-to-left direction
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.black,
              size: 26,
            ),
          if (icon != null) SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label $value ',
              textAlign: TextAlign.right,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
