// ignore_for_file: use_super_parameters, library_private_types_in_public_api, avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:spareparts/main.dart';
import 'package:spareparts/navigationPages/Home/Home.dart';
import 'package:spareparts/navigationPages/Home/ToTest.dart';
import 'package:spareparts/navigationPages/LikeIt.dart';
import 'package:spareparts/navigationPages/SearchFilter/search.dart';
//import 'package:spareparts/navigationPages/search.dart';
import 'package:spareparts/navigationPages/Profile/profile.dart';
import 'package:spareparts/navigationPages/SharePostNav/SharePostIfNotLogIn.dart';
import 'package:spareparts/navigationPages/SharePostNav/sharePost.dart';
// import 'ConnectionPages/LoginPage.dart';

class MySlidable extends StatefulWidget {
  const MySlidable({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MySlidable> {
  int _currentIndex = 4;

  final List<Widget> _screens = [
    const Profile(),
    LikeIt(),
    // ignore: avoid_print
    isLoggedIn ? const SharePost() : SharePostIfNotLogIn(),
    SearchParameters2(),
    const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: _screens[_currentIndex],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavigationBar(
                backgroundColor: Colors.black,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'אזור אישי',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: 'אהבתי',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.share),
                    label: 'פרסום',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'חיפוש  ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'דף הבית ',
                  ),
                ],
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
