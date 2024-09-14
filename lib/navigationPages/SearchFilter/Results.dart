// ignore_for_file: file_names, prefer_const_constructors, avoid_print, use_super_parameters, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:spareparts/navigationPages/Home/CardOfPost.dart';

class SearchResultsPage extends StatelessWidget {
  final List<QueryDocumentSnapshot> results;

  const SearchResultsPage(
      {required this.results, Key? key, required String category})
      : super(key: key);

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

  void toggleFavorite(String documentId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    DocumentReference docRef = FirebaseFirestore.instance
        .collection('favorites')
        .doc(user.uid)
        .collection('userFavorites')
        .doc(documentId);

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({'postId': documentId});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('מודעות לפי חיפוש שלך'),
        centerTitle: true,
      ),
      body: results.isEmpty
          ? Center(child: Text('No results found'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var data = results[index].data() as Map<String, dynamic>;
                String documentId = results[index].id;
                String manufacturer = data['manufacturer'];
                String types = data['types'];
                String Dates = data['Dates'];
                String typeofparts = data['typeofparts'];
                String price = data['Price'];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyWidget(documentId: documentId),
                                  ),
                                );
                              },
                              child: const Text(
                                'הצג הכל ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                toggleFavorite(documentId);
                              },
                            ),
                          ],
                        ),
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
                                  height: 150.0,
                                  autoPlay: false,
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: AllData(
                            manufacturer: manufacturer,
                            types: types,
                            Dates: Dates,
                            typeofparts: typeofparts,
                            price: price,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class AllData extends StatelessWidget {
  const AllData({
    super.key,
    required this.manufacturer,
    required this.types,
    required this.Dates,
    required this.typeofparts,
    required this.price,
  });

  final String manufacturer;
  final String types;
  final String Dates;
  final String typeofparts;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            '₪',
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.4)),
          ),
          Text(
            '$price',
            style: TextStyle(fontSize: 20),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(width: 20),
          Text(
            '$types ,',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(width: 0),
          Text(
            '$manufacturer',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            ' :יצרן',
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.4)),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            '$typeofparts',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            ' :סוג החלק',
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.4)),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            '$Dates',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            ' :שנת עליה ',
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.4)),
          ),
        ]),
      ],
    );
  }
}
