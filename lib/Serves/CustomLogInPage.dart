// ignore_for_file: file_names, non_constant_identifier_names, unused_element, avoid_print, sized_box_for_whitespace, use_super_parameters, prefer_const_constructors, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButtonPassword extends StatelessWidget {
  CustomButtonPassword({super.key});

  bool _isPasswordVisible = false;
  final passwordController = TextEditingController();

  void _Login() {
    Future<void> signInWithEmailPassword(String email, String password) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Sign-in successful, navigate to the home screen or perform further actions
        print('User signed in: ${userCredential.user!.uid}');
      } catch (e) {
        print('Error signing in: $e');
        // Handle sign-in errors here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 26, 26, 26),
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 330,
        height: 48,
        child: TextFormField(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          controller: passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            hintText: ':סיסמה ',
            hintStyle: TextStyle(
              height: 1,
              color: const Color.fromARGB(255, 2, 2, 2).withOpacity(0.3),
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
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                width: 2,
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
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
    );
  }

  void setState(Null Function() param0) {}
}
///////////////////////////////////////////////////////////////

class CustomebuttonEmail extends StatelessWidget {
  CustomebuttonEmail({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 26, 26, 26),
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 330,
        height: 48,
        child: TextFormField(
          controller: emailController,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            fillColor:
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
            filled: true,
            hintText: ':כתובת אימייל',
            hintStyle: TextStyle(
                color: const Color.fromARGB(255, 2, 2, 2).withOpacity(0.3),
                fontSize: 16,
                height: 1),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'images/email-login.png',
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                width: 2,
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
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
    );
  }
}

/////////////////////////////////////////////////
class LineWithOr extends StatelessWidget {
  const LineWithOr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
                height: 36,
              )),
        ),
        Text(
          "אפשר גם דרך",
          style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.7)),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 10.0,
              ),
              child: Divider(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
                height: 36,
              )),
        ),
      ]),
    ]);
  }
}

///////////////////////////////////////////////////////////
Container singInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: 250,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      border: Border.all(width: 1, color: const Color(0xff252527)),
      color: const Color.fromARGB(255, 98, 96, 96).withOpacity(0.9),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 43, 42, 42).withOpacity(0.4),
          blurRadius: 30,
          spreadRadius: 1,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: ElevatedButton(
      //   onPressed: _Login,
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'כניסה' : 'הרשמה',
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 221, 221, 221);
            }
            return Color.fromARGB(255, 244, 244, 244).withOpacity(0.9);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

////////////////////////////////////////////////////////
class SquareTitle extends StatelessWidget {
  const SquareTitle({super.key, required this.imagePath, this.onTap});
  final String imagePath;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
