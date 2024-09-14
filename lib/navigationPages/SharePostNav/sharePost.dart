// ignore_for_file: file_names, library_private_types_in_public_api, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, unnecessary_string_interpolations, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unused_local_variable, prefer_final_fields, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spareparts/main.dart';
import 'package:spareparts/navigationPages/SharePostNav/enums.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SharePost extends StatefulWidget {
  const SharePost({
    super.key,
  });

  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  int? imageIndex;
  int documentCount = 0;
  List<String> downloadUrls = [];
  List<File> _images = [];
  bool showImages = false;
  bool x = false;
  late String document;
  int k = 0;
  int? selectedImage;
  List<String> usageoptions = ["חדש", "משומש"];
  List<String> typecategories = ["מנוע", "גיר", "גוף המכונית", "פרונט "];

//  File? _image;
  var manufacturer;
  var types;
  var Dates;
  var Price;
  var Locations;
  var userPhone;
  var categories;
  // var typeofparts;
  var ifused;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
      });
    }
  }

  Future<void> _uploadImagesToFirebaseStorage(String documentId) async {
    print('This is my best rrrdocument $documents');
    for (int i = 0; i < _images.length; i++) {
      try {
        File imageFile = _images[i];
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Create a reference to the location you want to upload to in Firebase Storage
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/$documents/$fileName.jpg');

        // Upload the file to Firebase Storage
        UploadTask uploadTask = storageReference.putFile(imageFile);

        // Wait for the upload task to complete and fetch the download URL
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Print the download URL for the uploaded image
        print('Download URL for Image $i: $k');
      } catch (error) {
        print('Error uploading image $i: $error');
      }
    }
  }

  Future<void> changeImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        if (_images.isNotEmpty) {
          _images.removeAt(0);
        }
        _images.add(File(image.path));
        showImages = true;
      });
    }
  }

  TextEditingController Description = TextEditingController();
  TextEditingController PhoneNum = TextEditingController();
  TextEditingController typeofparts = TextEditingController();

  final CollectionReference Cars =
      FirebaseFirestore.instance.collection('Cars');
  Future<void> addCar() async {
    if (manufacturer == null || types == null || Dates == null) {
      print("Manufacturer, types, and dates must not be empty");
      // navigator.
      return;
    }

    String userFullname = '';
    String userPhone = '';
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? userEmail = '111';

    userEmail = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      userFullname = userSnapshot.docs[0].data()['name'];
      print('sssssssss ${userEmail}');
    } else {
      print('No user found with the email: $userEmail');
      return;
    }

    Map<String, List<String>> makeOptions = {
      // Sample data structure
      "Manufacturer1": ["Model1", "Model2"],
      "Manufacturer2": ["Model3", "Model4"],
    };
    DocumentReference carRef = await firestore.collection('Cars').add({
      'manufacturer': manufacturer.toString(),
      'types': types.toString(),
      'Dates': Dates.toString(),
      '_controller': Description.text,
      'Price': Price.toString(),
      'Locations': Locations.toString(),
      'NumberOfUser': PhoneNum.text,
      'name': userFullname,
      'email': userEmail,
      'typeofparts': typeofparts.text,
      'ifused': ifused,
      'categories': categories,
      'createdAt': FieldValue.serverTimestamp(),
      'Uid':
          FirebaseAuth.instance.currentUser?.uid, // Use the current user's UID
    });

    // Get the document ID
    String documentId = carRef.id;

    // Update the document with the document ID
    await firestore.collection('Cars').doc(documentId).update({
      'documentId': documentId,
    });
    print('llllllllllllll $documentId');
    documents = documentId;
    // Upload images after the document is created
    await _uploadImagesToFirebaseStorage(documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('פירסום מודעה חדשה '),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              // SizedBox(
              //     //width: 55,
              //     ),
              Container(
                width: 250, // Set the width of the container
                height: 80, // Set the height of the container

                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/LogoOfProjectBlack.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 290,
              ),
              Text(
                "יצרן",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 240, 239, 239)
                            .withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xff252527)),
                  ),
                  child: DropdownButton<String>(
                    underline: const Divider(
                      thickness: 0,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "בחירת יצרן",
                          textDirection: TextDirection.rtl,
                        )),
                    value: manufacturer,
                    items: selectedCardModel.map((e) {
                      return DropdownMenuItem<String>(
                          value: e,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('$e'),
                          ));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        manufacturer = val!;
                        types =
                            null; // Reset the types when manufacturer changes
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 290,
              ),
              Text(
                "דגם",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xff252527)),
                  ),
                  child: DropdownButton(
                    underline: const Divider(
                      thickness: 0,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "בחירת דגם",
                          textDirection: TextDirection.rtl,
                        )),
                    value: types,
                    items: manufacturer != null
                        ? makeOptions[manufacturer]?.map((e) {
                            return DropdownMenuItem<String>(
                                value: e,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('$e'),
                                ));
                          }).toList()
                        : null,
                    onChanged: (val) {
                      setState(() {
                        types = val!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 250,
              ),
              Text(
                "מצב החלק",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xff252527)),
                  ),
                  child: DropdownButton<String>(
                    underline: const Divider(
                      thickness: 0,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "בחירת סוג שימוש",
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    value: ifused,
                    items: usageoptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        ifused = val!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 26,
              ),
              Text(
                "סוג החלק",
                style: TextStyle(fontSize: 19),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250,
              height: 35,
              child: Directionality(
                textDirection: TextDirection.rtl, // Align text to the right
                child: TextField(
                  controller: typeofparts,
                  decoration: InputDecoration(
                    // labelText: ' פלאגים ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1), // Set your desired border color here
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      typeofparts.text = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Text(
                  "קטגוריה של החלק",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xff252527)),
                  ),
                  child: DropdownButton<String>(
                    underline: const Divider(
                      thickness: 0,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        " קטגוריות",
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    value: categories,
                    items: typecategories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        categories = val!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                    ),
                    Text(
                      ' עלות ',
                      style: TextStyle(fontSize: 19),
                    )
                  ],
                ),
                SizedBox(
                  width: 145,
                ),
                Container(
                  child: Text(
                    'שנה',
                    style: TextStyle(fontSize: 19),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 35,
                  child: Directionality(
                    textDirection: TextDirection.rtl, // Align text to the right
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ), // Allow only numbers and decimals
                      decoration: InputDecoration(
                        labelText: 'הכנס מחיר',
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1

                                  // Set your desired border color here
                                  ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          Price = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border:
                        Border.all(width: 1, color: const Color(0xff252527)),
                  ),
                  child: DropdownButton<String>(
                    underline: const Divider(
                      thickness: 0,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: SizedBox(
                        width: 120,
                        child: Text(
                          " 1971",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.4)),
                          textDirection: TextDirection.rtl,
                        )),
                    value: Dates,
                    items: dates.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("$e"),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        Dates = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 290,
              ),
              Text(
                "מיקום",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 240, 239, 239)
                            .withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xff252527)),
                  ),
                  child: DropdownButton<String>(
                    underline: const Divider(
                      thickness: 0,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "חיפה",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          textDirection: TextDirection.rtl,
                        )),
                    value: Locations,
                    items: LocationsArea.map((e) {
                      return DropdownMenuItem<String>(
                          value: e,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('$e'),
                          ));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        Locations = val!;
                        // Reset the types when manufacturer changes
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 25,
              ),
              Text(
                "נייד",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 250,
              height: 35,
              child: Directionality(
                textDirection: TextDirection.rtl, // Align text to the right
                child: TextField(
                  controller: PhoneNum,
                  keyboardType: TextInputType.number, // Allow only numbers
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10), // Limit length to 10
                    FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  ],
                  decoration: InputDecoration(
                    labelText: ' מספר נייד',
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1), // Set your desired border color here
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      PhoneNum.text = value;
                    });
                  },
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Divider(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                      height: 36,
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 195,
              ),
              Container(
                child: Text(
                  'טקסט תיאור',
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),

            Container(
              width: 300,
              height: 100,
              child: TextField(
                textDirection: TextDirection.rtl,
                controller: Description,
                decoration: const InputDecoration(
                  // labelText: 'תיאור',
                  hintTextDirection: TextDirection.rtl,
                  hintText: 'תיאור:',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    Description.text = value;
                  });
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    showImages = true;
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('גלרייה'),
                            onTap: () {
                              _pickImage(ImageSource.gallery);

                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('מצלמה'),
                            onTap: () {
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                'הוספת תמונות',
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                // primary: Colors.teal,
                side: const BorderSide(
                    color: Color.fromARGB(121, 0, 0, 0), width: 2.0),
                minimumSize: Size(40, 40),
              ),
            ),
            // SizedBox(height: 20),
            showImages
                ? Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Stack(
                            children: [
                              Container(
                                height: 90,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedImage = index;
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Image.file(_images[index]),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    showImages = true;

                                                    return Container(
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(Icons
                                                                .photo_library),
                                                            title:
                                                                Text('גלרייה'),
                                                            onTap: () {
                                                              changeImage(
                                                                  ImageSource
                                                                      .gallery);

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          ListTile(
                                                            leading: Icon(Icons
                                                                .camera_alt),
                                                            title:
                                                                Text('מצלמה'),
                                                            onTap: () {
                                                              changeImage(
                                                                  ImageSource
                                                                      .camera);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ); // או _pickImage(ImageSource.camera);
                                              },
                                              child: Text('שינוי'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _images.removeAt(index);
                                                  if (_images.isEmpty) {
                                                    showImages = false;
                                                  }
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text('מחיקה'),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  child: Image.file(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (selectedImage == index)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    // backgroundColor:
                                    //     Colors.red,
                                    radius: 10,
                                    child: Icon(
                                      Icons.cancel,
                                      color:
                                          const Color.fromARGB(255, 255, 0, 0),
                                      size: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(),

            SizedBox(
              height: 50,
            ),

            TextButton(
              onPressed: addCar,
              child: Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 240, 239, 239)
                          .withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: const Color(0xff252527)),
                  color: Color.fromARGB(255, 183, 183, 183).withOpacity(0.9),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    SizedBox(width: 11),
                    Text(
                      "הוספת פריט",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            //  _image == null ? Text('No image selected.') : Image.file(_image!),
          ],
        ),
      ),
    );
  }
}
