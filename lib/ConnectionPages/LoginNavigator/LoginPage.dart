// ignore_for_file: unnecessary_import, file_names, use_super_parameters, library_private_types_in_public_api, non_constant_identifier_names, duplicate_ignore, avoid_print, use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors

import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:spareparts/Serves/CustomLogInPage.dart';
import 'package:spareparts/ConnectionPages/SignUpNavigator/SignUp.dart';
import 'package:spareparts/Serves/auth_service.dart';
import 'package:spareparts/Serves/forgot_pass_page.dart';
import 'package:spareparts/Serves/navigation.dart';
import 'package:spareparts/Serves/sharedPreferences.dart';
import 'package:spareparts/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late final String imagePath;
  late final Function()? onTap;

  Future<void> _Login() async {
    print('This is my email: ${_emailController.text.trim()}');
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      isLoggedIn = true;
      print('User signed up: ${userCredential.user!.uid}');

      // Check if the user's email is verified
      if (!userCredential.user!.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please verify your email'),
            action: SnackBarAction(
              label: 'Resend',
              onPressed: () {
                userCredential.user!.sendEmailVerification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Verification email sent'),
                  ),
                );
              },
            ),
          ),
        );
      }

      // Sign-in successful, navigate to the home screen or perform further actions
      print('User signed in: ${userCredential.user!.uid}');
      SharedpreferencesService.setLoggedIn(true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MySlidable()));
    } on FirebaseAuthException catch (e) {
      print('Error signing in: $e');
      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        print(" No User found for this Email");
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'No User found for this Email',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'wrong-password') {
        print("Wrong Password provided for this User");
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'Wrong Password provided for this User',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  // ignore: unused_field, non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    //Bool isLogin;
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
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          isLoggedIn = false;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MySlidable()));
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) => const SignUpPage()));
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  Container(
                    width: double.infinity,
                    //height: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          ' כניסה לחשבון',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        const SizedBox(height: 30),
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
                        ), // EmailButton
                        const SizedBox(height: 30),
                        Material(
                          elevation: 10,
                          shadowColor: const Color.fromARGB(255, 26, 26, 26),
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 330,
                            height: 48,
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
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
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            // ignore: prefer_const_constructors
                            SizedBox(width: 25),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassWordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                ' שכחתי סיסמה',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ],
                        ),

                        //LogInButton
                        // Center(
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       onTap();
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       fixedSize: Size(300, 30),
                        //     ),
                        //     child: Text('login'),
                        //   ),
                        // ),

                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: _Login,
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
                                      "כניסה",
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
                        // singInSignUpButton(context, true, () {
                        //   FirebaseAuth.instance
                        //       .signInWithEmailAndPassword(
                        //           email:
                        //               CustomebuttonEmail().emailController.text,
                        //           password: CustomButtonPassword()
                        //               .passwordController
                        //               .text)
                        //       .then((value) {
                        //     Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //             builder: (ctx) => MySlidable()));
                        //   }).onError((error, stackTrace) {
                        //     print("Error ${error.toString()}");
                        //   });
                        // }),

                        const SizedBox(
                          height: 35,
                        ),
                        const LineWithOr(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareTitle(
                                onTap: () => AuthService().signInWithGoogle(),
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
                                onTap: () => AuthService().signInWithGoogle(),
                                child: Image.asset('images/apple-logo (1).png'),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            const SizedBox(
                              height: 0,
                              width: 80,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                              child: const Text(
                                '  עדיין לא נרשמתה? להרשמה  ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
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
