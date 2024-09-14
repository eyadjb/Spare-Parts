// ignore_for_file: file_names, use_super_parameters, prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spareparts/ConnectionPages/LoginNavigator/LoginPage.dart';
import 'package:spareparts/navigationPages/Home/Home.dart';
import 'package:spareparts/navigationPages/Home/ToTest.dart';
//import 'package:spareparts/navigationPages/Home.dart';
//import 'package:spareparts/navigationPages/sharePost.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
