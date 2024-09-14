import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _loadUserData();
    }
  }

  void _loadUserData() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user!.uid).get();
    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      _userNameController.text = data['name'] ?? '';
      _emailController.text = data['email'] ?? '';
      _phoneNumController.text = data['phone number'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ערוך פרופיל',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, // Adjust the font size as needed
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'מידע אישי',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              textDirection: TextDirection.rtl,
              controller: _userNameController,
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'שם משתמש :',
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'אימייל : ',
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true, // Hide the password text
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'סיסמה : ',
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneNumController,
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'מספר נייד : ',
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save changes to the backend
                  _saveChanges();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: const Text(
                  'שמירת שינוים',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    String name = _userNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String phoneNumber = _phoneNumController.text;

    try {
      // Update Firebase Authentication
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        if (email.isNotEmpty && email != currentUser.email) {
          try {
            await currentUser.updateEmail(email);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error updating email: $e')),
            );
            return;
          }
        }
        if (password.isNotEmpty) {
          try {
            await currentUser.updatePassword(password);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error updating password: $e')),
            );
            return;
          }
        }
      }

      // Update Firestore document
      await _firestore.collection('users').doc(currentUser!.uid).update({
        'name': name,
        'email': email,
        'phone number': phoneNumber,
      });

      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      // Navigate back to the previous page
      Navigator.pop(context);
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }
}
