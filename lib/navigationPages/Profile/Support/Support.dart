// ignore_for_file: file_names, use_super_parameters, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spareparts/ConnectionPages/SignUpNavigator/SignUp.dart';
import 'package:spareparts/navigationPages/Profile/PrivacyPolicyPage.dart';
import 'package:spareparts/navigationPages/Profile/Support/UserManual.dart';
import 'package:spareparts/navigationPages/Profile/Support/feedback.dart';
import 'package:spareparts/navigationPages/Profile/Support/reportError.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('תמיכה'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'שאלות נפוצות (FAQ)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: Text(
                'שאלות נפוצות',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              children: [
                ListTile(
                  title: const Text(
                    ' אך מפרסמים מודעה חדשה?',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  onTap: () {
                    // Add onTap functionality to show answer or navigate to answer page
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => UserManualPage()));
                  },
                ),
                ListTile(
                  title: const Text(
                    'אך ליצר חשבון חדש?',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  onTap: () {
                    // Add onTap functionality to show answer or navigate to answer page
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                ),

                // Add more FAQs as needed
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'פרטי יצירת קשר',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'eyadjbaren99@gmail.com',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.email),
                  ),
                ],
              ),
              // onTap: () async {
              //   final Uri _emailLaunchUri = Uri(
              //     scheme: 'mailto',
              //     path: 'support@example.com',
              //     queryParameters: {'subject': 'בקשת תמיכה'},
              //   );
              //   if (await canLaunch(_emailLaunchUri.toString())) {
              //     await launch(_emailLaunchUri.toString());
              //   } else {
              //     throw 'לא ניתן לפתוח אימייל';
              //   }
              // },
            ),
            const SizedBox(height: 20),
            // const Text(
            //   'שלח כרטיס תמיכה',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //   textDirection: TextDirection.rtl,
            // ),
            // const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to ticket submission form
            //     Navigator.push(
            //         (context),
            //         MaterialPageRoute(
            //             builder: (context) => SubmitTicketPage()));
            //   },
            //   child: Text(
            //     'שלח כרטיס',
            //     style: TextStyle(
            //         color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'משאבים שימושיים',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text(
                'מדריכי משתמש',
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                // Navigate to user guides
                Navigator.push((context),
                    MaterialPageRoute(builder: (context) => UserManualPage()));
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'טופס משוב',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to feedback form
                Navigator.push((context),
                    MaterialPageRoute(builder: (context) => FeedbackForm()));
              },
              child: Text(
                'ספק משוב',
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'קישורי רשת חברתית',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      launch('https://www.linkedin.com/in/eyad-jbaren/');
                    },
                    child: Image.asset(
                      'images/linkedin.png',
                      width: 30,
                    )),
                TextButton(
                    onPressed: () {
                      launch('https://www.instagram.com/');
                    },
                    child: Image.asset(
                      'images/instagram.png',
                      width: 30,
                    )),
                TextButton(
                    onPressed: () {
                      launch('https://www.facebook.com/?locale=he_IL');
                    },
                    child: Image.asset(
                      'images/facebook.png',
                      width: 30,
                    ))
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'דיווח על שגיאה',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ErrorReportPage()),
                );
              },
              child: Text(
                'דיווח על שגיאה',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'מדיניות פרטיות  ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text(
                'מדיניות פרטיות',
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                // Navigate to privacy policy page
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
