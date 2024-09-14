// ignore_for_file: file_names, use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

class SubmitTicketPage extends StatelessWidget {
  const SubmitTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'שלח כרטיס',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Subject',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 5,
              // Align text to the right
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to submit the ticket
                // Here you can send the ticket details to your backend or support system
                // You might want to validate the form fields before submitting
              },
              child: const Text('שלח'),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SubmitTicketPage()),
            );
          },
          child: const Text('Submit a Ticket'),
        ),
      ),
    );
  }
}
