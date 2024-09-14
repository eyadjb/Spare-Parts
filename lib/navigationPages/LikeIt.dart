// ignore_for_file: file_names, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spareparts/navigationPages/Home/CardOfPost.dart';

class LikeIt extends StatefulWidget {
  @override
  _LikeItState createState() => _LikeItState();
}

class _LikeItState extends State<LikeIt> {
  List<DocumentSnapshot> favoritePostsDetails = [];
  bool isLoading = true;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchFavoritePosts();
  }

  Future<void> fetchFavoritePosts() async {
    Set<String> favoritePostIds = await getFavoritePostIds();
    List<DocumentSnapshot> postsDetails =
        await getFavoritePostsDetails(favoritePostIds);
    setState(() {
      favoritePostsDetails = postsDetails;
      isLoading = false;
    });
  }

  Future<Set<String>> getFavoritePostIds() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .collection('userFavorites')
        .get();

    return snapshot.docs.map((doc) => doc.id).toSet();
  }

  // Future<List<DocumentSnapshot>> getFavoritePostsDetails(
  //     Set<String> favoritePostIds) async {
  //   List<DocumentSnapshot> posts = [];

  //   for (String postId in favoritePostIds) {
  //     DocumentSnapshot post =
  //         await FirebaseFirestore.instance.collection('Cars').doc(postId).get();
  //     posts.add(post);
  //   }

  //   return posts;
  // }
  Future<List<DocumentSnapshot>> getFavoritePostsDetails(
      Set<String> favoritePostIds) async {
    List<DocumentSnapshot> posts = [];

    for (String postId in favoritePostIds) {
      DocumentSnapshot post =
          await FirebaseFirestore.instance.collection('Cars').doc(postId).get();
      if (post.exists) {
        posts.add(post);
      } else {
        print('Document with ID $postId does not exist');
      }
    }

    return posts;
  }

  Future<void> removeFavoritePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .collection('userFavorites')
          .doc(postId)
          .delete();

      setState(() {
        favoritePostsDetails.removeWhere((post) => post.id == postId);
      });

      print('Favorite post successfully removed.');
    } catch (e) {
      print('Error removing favorite post: $e');
    }
  }

  void showContent(String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWidget(documentId: documentId),
      ),
    );
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
    } catch (e) {
      print('Error loading images: $e');
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('המוצרים האהובים'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: favoritePostsDetails.length,
                itemBuilder: (context, index) {
                  var document = favoritePostsDetails[index];
                  String documentId = document.id;
                  String manufacturer = document['manufacturer'];
                  String types = document['types'];
                  String Dates = document['Dates'];
                  String typeofparts = document['typeofparts'];
                  String price = document['Price'];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () => showContent(documentId),
                      child: Container(
                        decoration: BoxDecoration(
                            // gradient: const LinearGradient(
                            //   colors: [
                            //     Color.fromARGB(255, 154, 154, 154),
                            //     Color.fromARGB(255, 231, 230, 236),
                            //     Color.fromARGB(255, 216, 216, 219),
                            //   ],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1,
                                color: Colors.black.withOpacity(0.2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                            onPressed: () async {
                                              await removeFavoritePost(
                                                  documentId);
                                              Navigator.pop(context);
                                            },
                                            child: const Center(
                                              child: Text(
                                                'Remove from Favorites',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 179, 72, 64),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.more_vert),
                            ),
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
                                  print('Image URLs: ${snapshot.data}');

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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                    ),
                  );
                },
              ),
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
