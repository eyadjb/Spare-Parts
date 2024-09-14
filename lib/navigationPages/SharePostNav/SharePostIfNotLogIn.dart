// ignore_for_file: unnecessary_import, file_names, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spareparts/ConnectionPages/SignUpNavigator/SignUp.dart';
import 'package:spareparts/main.dart';

import '../../ConnectionPages/LoginNavigator/LoginPage.dart';

class SharePostIfNotLogIn extends StatefulWidget {
  @override
  _SharePostIfNotLogInState createState() => _SharePostIfNotLogInState();
}

class _SharePostIfNotLogInState extends State<SharePostIfNotLogIn> {
  final islogin = isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                Color.fromARGB(255, 138, 138, 138),
                Color.fromARGB(255, 0, 0, 0)
              ],
            ),
            image: DecorationImage(
              image: AssetImage('images/LogoOfProject3.png'),
              alignment: FractionalOffset(0, -0.2),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  child: const Text(
                    ' ? שנתחבר ',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 190, 190, 190),
                    ),
                  ),
                ),
                Container(
                  child: const Text(
                    'ואז תופיע פה אופצית הפרסום',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 190, 190, 190),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 240, 239, 239)
                              .withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 1,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: const Color(0xff252527)),
                      color: const Color.fromARGB(255, 98, 96, 96)
                          .withOpacity(0.9),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                        SizedBox(width: 11),
                        Text(
                          "כניסה",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 240, 239, 239)
                              .withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 1,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: const Color(0xff252527)),
                      color:
                          Color.fromARGB(255, 243, 243, 243).withOpacity(0.9),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.app_registration_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        SizedBox(width: 11),
                        Text(
                          "להרשמה",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
