// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('מדריכי משתמש'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ': Introduction',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'ברוכים הבאים לאפליקציה שלנו לקנייה ומכירה של חלקי חילוף למכוניות! בין אם אתה חובב רכב שמחפש חלקים ספציפיים או מוכר שרוצה להגיע לקונים פוטנציאליים, האפליקציה שלנו מספקת פלטפורמה נוחה לענות על הצרכים שלך.',
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 20.0),
            Text(
              ': מתחילים',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'יצירת חשבון: אתה יכול לחקור את האפליקציה ולעיין ברשימות מבלי להתחבר. עם זאת, כדי לפרסם פרסומות, לשמור מועדפים או לגשת לתכונות מתקדמות, תצטרך ליצור חשבון.',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            Text(
              'כניסה: אם כבר יש לך חשבון, פשוט היכנס באמצעות האימייל, Google או Apple שלך.',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 20.0),

            Text(
              ': דפדוף ברשימות',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 10.0),

            Text(
              'דף הבית: מצא את הפרסומות והפריטים הטובים ביותר במבצע. גלול בין הרישומים והקש על כל פריט כדי להציג את הפרטים שלו.',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            Text(
              'חיפוש ומסננים: השתמש בסרגל החיפוש או החל מסננים כדי לצמצם את תוצאות החיפוש לפי מותג, דגם, טווח מחירים וכו\'.',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),

            // Repeat similar patterns for other sections
          ],
        ),
      ),
    );
  }
}
