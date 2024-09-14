// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api, non_constant_identifier_names, unused_element, use_build_context_synchronously, avoid_print, prefer_const_constructors, sized_box_for_whitespace

import 'dart:ui';
//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spareparts/Serves/CustomLogInPage.dart';
import 'package:spareparts/Serves/auth_service.dart';
import 'package:spareparts/Serves/navigation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _NumberUser = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = FirebaseAuth.instance.currentUser;

      FirebaseFirestore.instance.collection('users').add({
        'name': _userNameController.text, // John Doe
        'NumberOFuser': _NumberUser.text,
        'email': _emailController.text,
        'Uid': user?.uid, // Stokes and Sons
      });
      // .then((value) => print("User Added"))
      // .catchError((error) => print("Failed to add user: $error"));

      Future<void> addUser() async {
        // Call the user's CollectionReference to add a new user
        //  users
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MySlidable()));
      print('User signed up: ${userCredential.user!.uid}');

      // Navigate to another screen or perform further actions after successful sign up
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('Error occurred while signing up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login-background-100.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: const Center(child: Text('')),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 0),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'הרשמה',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 15),
                        const Text(
                          '...צאט, התראות, פרסום מודעות ועוד',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const Text(
                          '.שומרים את הדברים הטובים לחבאים',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        Material(
                          elevation: 10,
                          shadowColor: const Color.fromARGB(255, 26, 26, 26),
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 330,
                            height: 48,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 239, 232, 232)
                                          .withOpacity(0.1), // shadow color
                                  spreadRadius: 2, // spread radius
                                  blurRadius: 30, // blur radius
                                  offset: const Offset(
                                      10, 0.6), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _userNameController,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.4),
                                filled: true,
                                hintText: 'שם משתמש',
                                hintStyle: TextStyle(
                                    color: const Color.fromARGB(255, 2, 2, 2)
                                        .withOpacity(0.3),
                                    fontSize: 16,
                                    height: 1),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'images/user-name-icon.jpeg',
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        Material(
                          elevation: 10,
                          shadowColor: const Color.fromARGB(255, 26, 26, 26),
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 330,
                            height: 48,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 239, 232, 232)
                                          .withOpacity(0.1), // shadow color
                                  spreadRadius: 2, // spread radius
                                  blurRadius: 30, // blur radius
                                  offset: const Offset(
                                      10, 0.6), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _NumberUser,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.4),
                                filled: true,
                                hintText: 'מספר נייד',
                                hintStyle: TextStyle(
                                  color: const Color.fromARGB(255, 2, 2, 2)
                                      .withOpacity(0.3),
                                  fontSize: 16,
                                  height: 1,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'images/phone_number.jpg',
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // your decoration

                        SizedBox(height: 30),
                        Material(
                          elevation: 10,
                          shadowColor: const Color.fromARGB(255, 26, 26, 26),
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 330,
                            height: 48,
                            child: TextFormField(
                              controller: _emailController,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                // your decoration

                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.4),
                                filled: true,
                                hintText: ':כתובת אימייל',
                                hintStyle: TextStyle(
                                    color: const Color.fromARGB(255, 2, 2, 2)
                                        .withOpacity(0.3),
                                    fontSize: 16,
                                    height: 1),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'images/email-login.png',
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Material(
                          elevation: 10,
                          shadowColor: const Color.fromARGB(255, 26, 26, 26),
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 330,
                            height: 48,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                filled: true,
                                hintText: ':סיסמה ',
                                hintStyle: TextStyle(
                                  height: 1,
                                  color: const Color.fromARGB(255, 2, 2, 2)
                                      .withOpacity(0.3),
                                  fontSize: 16,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'images/pass-login.png',
                                  ),
                                ),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: _signUp,
                              child: Container(
                                width: 250,
                                height: 40,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 240, 239, 239)
                                          .withOpacity(0.4),
                                      blurRadius: 30,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: const Color(0xff252527)),
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
                                      "הרשמה",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: const Divider(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      height: 36,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "OR",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 10.0,
                                    ),
                                    child: const Divider(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      height: 36,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SquareTitle(
                                    onTap: () =>
                                        AuthService().signInWithGoogle(),
                                    imagePath: 'images/google-icon.png'),
                                const SizedBox(width: 25),
                                // Container(
                                //   width: 100,
                                //   child: SquareTitle(
                                //     onTap: () => AuthService().siginInWithGoogle(),
                                //     imagePath: ' images/google-icon.png',
                                //   ),
                                // )
                                Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[200],
                                  ),
                                  child: GestureDetector(
                                    onTap: () =>
                                        AuthService().signInWithGoogle(),
                                    child: Image.asset(
                                        'images/apple-logo (1).png'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
