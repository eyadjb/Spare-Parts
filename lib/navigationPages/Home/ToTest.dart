// ignore_for_file: unused_import, file_names, library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_super_parameters

import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spareparts/navigationPages/Home/ImagesTimer.dart';
import 'package:spareparts/navigationPages/Home/adStory.dart';
import 'package:spareparts/navigationPages/SearchFilter/Results.dart';
import 'package:spareparts/navigationPages/Home/Silder.dart';
import 'package:spareparts/navigationPages/Home/shapeOfHome.dart';
import 'package:spareparts/navigationPages/SearchFilter/SearchCategory.dart';
import 'package:spareparts/navigationPages/SearchFilter/SearchR.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("Cars").get();
      setState(() {
        data.addAll(querySnapshot.docs);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  // void navigateToCategory(String categories) {
  //   List<QueryDocumentSnapshot> filteredResults = data.where((doc) {
  //     // Cast the document data to a Map
  //     final Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;

  //     // Check if the 'categories' field exists before comparing
  //     if (docData.containsKey('categories')) {
  //       return docData['categories'] == categories;
  //     } else {
  //       return false;
  //     }
  //   }).toList();

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SearchResultsPage1(
  //         results: filteredResults,
  //         categories: categories,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String message = '';

    if (now.hour >= 6 && now.hour < 12) {
      message = 'בוקר טוב';
    } else if (now.hour >= 12 && now.hour < 18) {
      message = 'צוהריים טובים';
    } else {
      message = 'ערב טוב';
    }

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60.0),
      //   child: AppBar(
      //     backgroundColor: Color.fromARGB(80, 2, 2, 2),
      //     title: Text(message),
      //     centerTitle: true,
      //   ),
      // ),
      body: errorMessage != null
          ? Center(child: Text('Error: $errorMessage'))
          : isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: ShapeOfHome(),
                        child: Container(
                          width: 400,
                          color: Color.fromARGB(80, 2, 2, 2),
                          padding: const EdgeInsets.all(0),
                          child: SizedBox(
                            height: 270,
                            child: Stack(
                              children: [
                                Positioned(
                                  width: 395,
                                  // bottom: 90,
                                  // top: 10,
                                  // right: 2,
                                  // left: 0,
                                  child: Container(
                                    // width: 10,
                                    child: Image.asset(
                                      'images/depositphotos_325830262-stock-photo-car-parts-black-background-copy.jpg',
                                      fit: BoxFit.cover,
                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 0,
                                  right: 330,
                                  child: Container(
                                    width: 200,
                                    height: 130,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(700),
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 330,
                                  child: Container(
                                    width: 200,
                                    height: 170,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(700),
                                      color: Color.fromARGB(255, 202, 202, 202)
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),

                                // Positioned(
                                //   top: 0,
                                //   left: 0,
                                //   right: 0,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(16.0),
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.end,
                                //       children: [
                                //         SizedBox(height: 10),
                                //         Container(
                                //           height: 130,
                                //           child: ListView.builder(
                                //             itemCount: 6,
                                //             scrollDirection: Axis.horizontal,
                                //             itemBuilder: (_, index) {
                                //               return Container(); // Replace with your ad widgets
                                //             },
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 170,
                                  left: 20,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchParameters(
                                            onSearch: (searchParameters) {
                                              // Implement your search logic
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                              textDirection: TextDirection.ltr,
                                              Icons.search,
                                              color: Colors.black),
                                          SizedBox(width: 240),
                                          Text(
                                            textAlign: TextAlign.end,
                                            'חיפוש',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 120,
                        right: 160,
                        child: Center(
                            child: Text(
                          message,
                          style: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 23, 23, 23)),
                        )),
                      ),
                      SizedBox(height: 20),

                      // Categories Section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 1),
                            Text(
                              'קטגוריות פופולריות',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 90,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  buildCategoryButton(
                                    'מנוע',
                                    'images/engineRed.png',
                                    Icons.engineering,
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilteredAdsPage(
                                          category: 'מנוע',
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildCategoryButton(
                                    'גיר',
                                    'images/tranmioo.png',
                                    Icons.engineering,
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilteredAdsPage(
                                          category: 'גיר',
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildCategoryButton(
                                    'גוף ',
                                    'images/Bodycar.png',
                                    Icons.engineering,
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilteredAdsPage(
                                          category: 'גוף המכונית',
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildCategoryButton(
                                    'פרונט',
                                    'images/suspension.png',
                                    Icons.engineering,
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilteredAdsPage(
                                          category: 'פרונט',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Other sections...
                      // Recently Posted Section
                      const Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'שהתפרסמו לאחרונה',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SlideWidget(),
                      ),

                      // Promotional Banners Section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 16),
                            Text(
                              'מבצעים מיוחדים',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 150.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                enableInfiniteScroll: true,
                                autoPlayInterval: Duration(minutes: 1),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 2500),
                                viewportFraction: 0.8,
                              ),
                              items: ['images/Advir.jpg', 'images/Advir3.jpg']
                                  .map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 57, 56, 56),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(width: 2)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ),
    );
  }

  Widget buildCategoryButton(
      String title, String imageUrl, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      // borderRadius: BorderRadius.circular(20), // Adjusted for smoother corners
      child: Container(
        width: 80, // Increased width for more space
        height: 90,

        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(255, 100, 100, 100),
          //     Color.fromARGB(52, 255, 255, 255)
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ), // Added a gradient background
          borderRadius: BorderRadius.circular(20), // Adjusted border radius
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )),
            SizedBox(height: 1),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(
                    255, 0, 0, 0), // White text for contrast
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
