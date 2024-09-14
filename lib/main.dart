// ignore_for_file: unused_import, use_super_parameters, camel_case_types, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spareparts/ConnectionPages/LoginNavigator/LoginPage.dart';
import 'package:spareparts/Serves/firebase_options.dart';
import 'package:spareparts/Serves/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spareparts/Serves/sharedPreferences.dart';
import 'package:spareparts/navigationPages/Home/Home.dart';
// import 'package:spareparts/navigationPages/Home/storyData.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';

bool isLoggedIn = false;

SharedPreferences? profile;
String documents = '12';
void main() async {
  //FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: '6LeTr6ApAAAAAJjfQiDlKzH6uYT6VeMATjP-qR1T');
  //await SharedpreferencesService.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // name: 'spareparts',
  //options: DefaultFirebaseOptions.currentPlatform,
  //);
  // Run the app
  runApp(const FinalProject());
}

class FinalProject extends StatefulWidget {
  const FinalProject({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _myAppState();
}

class _myAppState extends State<FinalProject> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('======================User is currently signed out!');
      } else {
        print('=====================User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySlidable(), // Replace MySlidable() with your desired widget
      // home: FirebaseAuth.instance.currentUser == null
      //     ? LoginPage()
      //     : MySlidable(),
      routes: {},
    );
  }
}
