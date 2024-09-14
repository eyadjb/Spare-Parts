// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassWordPage extends StatefulWidget {
  const ForgotPassWordPage({super.key});

  @override
  State<ForgotPassWordPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ForgotPassWordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordRest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 165, 56, 56),
          elevation: 0,
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
              width: 100,
              // height: 300,
              decoration: BoxDecoration(),
              child: Image.asset(
                'images/forgot.png',
              )),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'לשחזור סיסמה , צריך לשרום כתובת אימייל',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15,
            ),
            child: TextField(
              controller: _emailController,
              textAlign: TextAlign.end,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.all(Radius.circular(12))

                      // borderRadius: BorderRadius.circular()
                      ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(12))

                      // borderRadius: BorderRadius.all(12.0)
                      ),
                  hintText: 'אימייל',
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
          OutlinedButton(
            onPressed: passwordRest,
            style: OutlinedButton.styleFrom(
              fixedSize: Size(200, 50),
              backgroundColor: Color.fromARGB(36, 146, 146, 146),
              side: BorderSide(
                  color: Colors.black,
                  width: 2.0), // Set border color and width
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Optional: Set border radius
              ),
              // padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 0.0),
            ),
            child: Text('שחזר סיסמה',
                style: TextStyle(color: Colors.black, fontSize: 17)),
          )
        ],
      ),
    );
  }
}
