// ignore_for_file: use_super_parameters, non_constant_identifier_names, use_build_context_synchronously, avoid_print, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spareparts/ConnectionPages/LoginNavigator/LoginPage.dart';
import 'package:spareparts/Serves/camera-profile-func.dart';
import 'package:spareparts/Serves/navigation.dart';
import 'package:spareparts/Serves/sharedPreferences.dart';
import 'package:spareparts/main.dart';
import 'package:spareparts/navigationPages/LikeIt.dart';
import 'package:spareparts/navigationPages/Profile/EditProfile.dart';
import 'package:spareparts/navigationPages/Profile/PrivacyPolicyPage.dart';
import 'package:spareparts/navigationPages/Profile/Support/Support.dart';
import 'package:spareparts/navigationPages/Profile/myPosts.dart';
import 'package:spareparts/navigationPages/SharePostNav/sharePost.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

//bool isLoggedIn = false;

class _ProfileState extends State<Profile> {
  // ignore: unused_field
  late SharedPreferences _prefs; // Declare _prefs as late
  File? _image;

  @override
  void initState() {
    super.initState();
    initializePrefs(); // Initialize _prefs
    //isLoggedIn = SharedpreferencesService.isLoggedIn();
  }

  void initializePrefs() async {
    _prefs = await SharedPreferences.getInstance(); // Initialize _prefs
    isLoggedIn = SharedpreferencesService.isLoggedIn();
    setState(() {}); // Trigger a rebuild after initializing _prefs
  }

  Future<String?> getUserUID() async {
    // Get the current user from FirebaseAuth instance
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is not null
    if (user != null) {
      // Return the UID of the user
      return user.uid;
    } else {
      // If user is null, return null
      return null;
    }
  }

  void Login() async {
    setState(() async {
      String? uid = await getUserUID();

      if (uid != null) {
        isLoggedIn = true;
      } else if (uid == null) {
        isLoggedIn = false;
      }
      if (isLoggedIn) {
        // Logout
        await FirebaseAuth.instance.signOut();
        SharedpreferencesService.setLoggedIn(false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MySlidable()),
        ); //Checking
      } else {
        //Login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
      isLoggedIn = !isLoggedIn;
    });
  }

  void _showOptionsDialog() {
    ProfileFunctions.showOptionsDialog(context, (image) {
      setState(() {
        _image = image;
      });
    });
  }

  void _showImageDialog() {
    ProfileFunctions.showImageDialog(context, _image);
  }

  //to get the userName
  Future<String?> getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('Uid', isEqualTo: uid)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          String username = data['name'];
          return username;
        } else {
          print('');
          return null;
        }
      } catch (e) {
        print('Error getting username: $e');
        return null;
      }
    } else {
      print('No user signed in.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int morningStartHour = 6; // 6 AM
    int noonStartHour = 12;
    int nightStartHour = 18; // 6 PM

    String message = '';

    if (now.hour >= morningStartHour && now.hour < noonStartHour) {
      message = 'בוקר טוב';
    } else if (now.hour >= noonStartHour && now.hour < nightStartHour) {
      message = 'צוהריים טובים';
    } else if (now.hour >= nightStartHour) {
      message = ('ערב טוב ');
    }

    return Scaffold(
      body: Container(
        child: Stack(
          textDirection:
              TextDirection.rtl, // Set text direction to right-to-left
          children: [
            Positioned(
              right: 152,
              top: 30,
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            // Image.asset(''),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.8), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              // color: const Color.fromARGB(80, 2, 2, 2),
            ),
            Container(
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  SizedBox(
                    height: 58,
                  ),
                  Center(
                    child: FutureBuilder<String?>(
                      future: getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Text('');
                        } else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // padding: EdgeInsets.only(left: 20, right: 20),
                                // Text(
                                //   message,
                                //   style: TextStyle(
                                //     fontSize: 18,
                                //     color: Colors.black.withOpacity(0.7),
                                //   ),
                                // ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  snapshot.data!,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ]);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  isLoggedIn
                      ? ProfileFunctions.profileAvatar(
                          context,
                          _image,
                          _showOptionsDialog,
                          _showImageDialog,
                        )
                      : Column(children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  2.0), // Adjust padding to create the border effect
                              child: Container(
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(255, 171, 171, 171),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const ClipOval(
                                      child: Icon(
                                    Icons.no_photography_outlined,
                                    size: 40,
                                  ))),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 200,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                    width: 2,
                                    color: Colors.black.withOpacity(0.6))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text(
                                ' התחברות ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ]),
                  const SizedBox(
                    height: 0,
                  ),
                  isLoggedIn
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfile()),
                                  );
                                },
                                child: const Text(
                                  'ערוך פרופיל שלך ',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            // if (isLoggedIn)
                            ProfileMenuWidget(
                              title: 'פרסום מודעה',
                              icon: Icons.ios_share,
                              iconColor: const Color.fromARGB(255, 0, 0, 0),
                              onPress: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) => SharePost()));
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            isLoggedIn
                                ? ProfileMenuWidget(
                                    title: 'מודעות שפרסמתי',
                                    icon: Icons.share_sharp,
                                    iconColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    onPress: () {
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) => Posts()));
                                    },
                                  )
                                : const SizedBox(
                                    height: 15,
                                  ),
                            isLoggedIn
                                ? ProfileMenuWidget(
                                    title: 'מודעות שאהבתי ',
                                    icon: Icons.favorite,
                                    iconColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    onPress: () {
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) => LikeIt()));
                                    },
                                  )
                                : const SizedBox(
                                    height: 10,
                                  ),
                            ProfileMenuWidget(
                              title: 'מדיניות פרטיות ',
                              icon: Icons.privacy_tip,
                              iconColor: const Color.fromARGB(255, 0, 0, 0),
                              onPress: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrivacyPolicyPage()));
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            ProfileMenuWidget(
                              title: 'צור קשר',
                              icon: Icons.support_agent,
                              onPress: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) => SupportPage()));
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ProfileMenuWidget(
                                title: isLoggedIn ? 'התנתקות' : 'התחבר',
                                icon: Icons.exit_to_app,
                                iconColor: const Color.fromARGB(255, 255, 0, 0),
                                onPress: Login //() {
                                // FirebaseAuth.instance.signOut().then((value) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => const MySlidable()));
                                // });
                                //  },
                                //endicon: true,
                                //textColor: Colors.red,
                                ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
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
    );
  }
}

class FavoritePosts {}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endicon = true,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endicon;
  final Color? textColor;
  final Color? iconColor;
  // final isLoggedIn? islogin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 25,
        ),
      ),
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: textColor,
        ),
      ),
      trailing: endicon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            )
          : null,
      onTap: onPress,
    );
  }
}
