// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_super_parameters, library_private_types_in_public_api, prefer_collection_literals, avoid_print, prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spareparts/main.dart';
import 'package:spareparts/navigationPages/Home/CardOfPost.dart';

class Homes2 extends StatefulWidget {
  final String searchQuery; // Added searchQuery parameter

  Homes2({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes2> {
  double avg = 0.1;
  Map<String, dynamic> ratersDict = {};
  bool isLogged = isLoggedIn;
  bool love = true;

  Set<String> favoritePosts = Set();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchFavoritePosts();
  }

  Future<void> fetchFavoritePosts() async {
    if (user == null) return;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .collection('userFavorites')
        .get();

    setState(() {
      favoritePosts = snapshot.docs.map((doc) => doc.id).toSet();
    });
  }

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
      print('Image URLs for document $documentId: $imageUrls');
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

  void toggleFavorite(String documentId) async {
    if (favoritePosts.contains(documentId)) {
      // Remove from local set
      setState(() {
        favoritePosts.remove(documentId);
      });

      // Remove from Firestore
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .collection('userFavorites')
          .doc(documentId)
          .delete();
    } else {
      // Add to local set
      setState(() {
        favoritePosts.add(documentId);
      });

      // Add to Firestore
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .collection('userFavorites')
          .doc(documentId)
          .set({'postId': documentId});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Modify the query to filter by searchQuery
    Stream<QuerySnapshot> postsStream = widget.searchQuery.isEmpty
        ? FirebaseFirestore.instance
            .collection('Cars')
            .where('createdAt',
                isGreaterThanOrEqualTo: Timestamp.fromDate(
                    DateTime.now().subtract(Duration(days: 30))))
            .where('createdAt',
                isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
            .snapshots()
        : FirebaseFirestore.instance
            .collection('Cars')
            .where('manufacturer', isEqualTo: widget.searchQuery)
            .snapshots();

    return Container(
      padding: EdgeInsets.all(8),
      width: 600,
      child: StreamBuilder<QuerySnapshot>(
        stream: postsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          print('Number of documents: ${snapshot.data!.docs.length}');

          List<Widget> cards = [];

          var filteredDocs = snapshot.data!.docs;

          for (var document in filteredDocs) {
            String documentId = document.id;
            String manufacturer = document['manufacturer'];
            String types = document['types'];
            String Dates = document['Dates'];
            String typeofparts = document['typeofparts'];
            String price = document['Price'];

            print('Document ID: $documentId, Manufacturer: $manufacturer');

            cards.add(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isLoggedIn == true)
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => showContent(documentId),
                              child: const Text(
                                'הצג הכל ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            SizedBox(width: 222),
                            IconButton(
                              icon: Icon(
                                favoritePosts.contains(documentId)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoritePosts.contains(documentId)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                toggleFavorite(documentId);
                              },
                            ),
                          ],
                        )
                      else
                        Row(children: [
                          TextButton(
                            onPressed: () => showContent(documentId),
                            child: const Text(
                              'הצג הכל ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ]),
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
                            print('Image URLs: ${snapshot.data}');

                            return CarouselSlider.builder(
                              itemCount: snapshot.data!.length,
                              options: CarouselOptions(
                                  height: 150.0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.9,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 2000)),
                              itemBuilder:
                                  (BuildContext context, int index, _) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullImageScreen(
                                            imageUrl: snapshot.data![index]),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: snapshot.data![index],
                                    child: Container(
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
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: 0),
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
                      SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            );
          }

          return ListView(
            scrollDirection: Axis.horizontal,
            children: cards,
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
            '$Dates',
            style: TextStyle(fontSize: 17),
          ),
          Text(
            ' :שנת עליה ',
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
      ],
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  FullImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Image'),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
