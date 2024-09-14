import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ErrorReportPage extends StatefulWidget {
  @override
  _ErrorReportPageState createState() => _ErrorReportPageState();
}

class _ErrorReportPageState extends State<ErrorReportPage> {
  final TextEditingController _errorDescriptionController =
      TextEditingController();

  Future<void> _sendErrorReport(String description) async {
    final String username =
        'eyadjbaren99@gmail.com'; // Your Gmail email address
    final String password = 'Roaya12345*'; // Your Gmail email password

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Spare parts')
      ..recipients.add('eyadjbaren99@gmail.com') // Your email
      ..subject = 'Error Report from User'
      ..text = 'Error Description: $description';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      // ignore: nullable_type_in_catch_clause
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('דיווח על שגיאה'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _errorDescriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'תיאור השגיאה',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final description = _errorDescriptionController.text;
                  if (description.isNotEmpty) {
                    await _sendErrorReport(description);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('דיווח נשלח בהצלחה')),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('אנא הזן תיאור שגיאה')),
                    );
                  }
                },
                child: Text(
                  'שלח דיווח',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
