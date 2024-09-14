// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFunctions {
  static Future<File?> getImage(
      BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  static Future<void> uploadImageToFirebase(File image) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Upload image to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profileImages/${user.uid}');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Save download URL to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'profileImageUrl': downloadURL,
      }, SetOptions(merge: true));

      print('Image uploaded successfully: $downloadURL');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  static Future<String?> getProfileImageUrl() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (documentSnapshot.exists) {
      return documentSnapshot['profileImageUrl'];
    }
    return null;
  }

  static void showOptionsDialog(
      BuildContext context, Function(File?) setImage) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Change Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from Gallery'),
              onTap: () async {
                File? image = await getImage(context, ImageSource.gallery);
                if (image != null) {
                  await uploadImageToFirebase(image);
                }
                setImage(image);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () async {
                File? image = await getImage(context, ImageSource.camera);
                if (image != null) {
                  await uploadImageToFirebase(image);
                }
                setImage(image);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  static void showImageDialog(BuildContext context, File? image) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: image != null
            ? Image.file(image)
            : const Text('No image selected.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static Widget profileAvatar(BuildContext context, File? image,
      Function() showOptionsDialog, Function() showImageDialog) {
    return GestureDetector(
      onTap: showImageDialog,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: image != null ? FileImage(image) : null,
            child:
                image == null ? const Icon(Icons.camera_alt, size: 30) : null,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: showOptionsDialog,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildProfileScreen(BuildContext context) {
    return FutureBuilder<String?>(
      future: getProfileImageUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          String? imageUrl = snapshot.data;
          File? imageFile;
          if (imageUrl != null) {
            // Load the image file from the URL (this part requires modification, as File doesn't support URLs)
            // You might need to use a NetworkImage or other method to display the image
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileAvatar(
                context,
                imageFile,
                () => showOptionsDialog(context, (File? newImage) {
                  // handle image change
                }),
                () => showImageDialog(context, imageFile),
              ),
            ],
          );
        }
      },
    );
  }
}
