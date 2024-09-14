// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('טופס משוב'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                labelText: 'שם מלא',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                labelText: 'כתובת דוא"ל',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'הודעה',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // פעולה לשליחת המשוב
                _submitFeedback();
              },
              child: Text('שלח משוב'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() {
    // כאן תוכל להכניס קוד לשליחת המשוב
    String name = _nameController.text;
    String email = _emailController.text;
    String message = _messageController.text;

    // הדפסה לדוגמה של המשוב בקונסול
    print('שליחת משוב:');
    print('שם: $name');
    print('דוא"ל: $email');
    print('הודעה: $message');

    // אפשר להוסיף כאן לוגיקה נוספת כמו שליחת המשוב לשרת או הצגת הודעה למשתמש
  }
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: FeedbackForm(),
//   ));
// }
