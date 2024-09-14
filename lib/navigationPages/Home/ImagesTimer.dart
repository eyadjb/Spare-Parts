// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final String imagePath;
  final String itemImagePath; // New parameter for the item image
  final String itemText; // New parameter for item text
  final int duration; // duration in seconds
  const ImagePage({
    Key? key,
    required this.imagePath,
    required this.itemImagePath,
    required this.itemText, // Include itemText parameter
    required this.duration,
  }) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late Timer _timer;
  double _progress = 0.0; // Progress value

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.1 / widget.duration; // Update progress
      });
      if (_progress >= 1.0) {
        _timer.cancel(); // Stop the timer
        Navigator.pop(context); // Navigate back after timer ends
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.fill,
              width: double.infinity, // Full screen width
              height: double.infinity, // Full screen height
            ),
          ),
          // Linear Progress Indicator at the top
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14), // Rotate 180 degrees
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          // Positioned circular item image and text
          Positioned(
            top: 80, // Adjust position as needed
            right: 16, // Adjust position from the right
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  Text(
                    widget.itemText, // Use the item text passed
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Match the home page style
                    ),
                  ),
                  SizedBox(
                    height: 6,
                    width: 10,
                  ), // Space between text and image
                  Container(
                    width: 45,
                    height: 45,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Image(
                        image: AssetImage(widget.itemImagePath),
                        fit: BoxFit.cover, // Use the new item image path
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
