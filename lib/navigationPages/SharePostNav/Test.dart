// ignore_for_file: file_names
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:spareparts/navigationPages/SharePostNav/enums.dart';

// class SharePost extends StatefulWidget {
//   const SharePost({
//     super.key,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _SharePostState createState() => _SharePostState();
// }

// class _SharePostState extends State<SharePost> {
//   var manufacturer;
//   CarType? type;
//   var from;
//   var to;
//   final CollectionReference _carsCollection =
//       FirebaseFirestore.instance.collection('Cars');
//   Future<void> addCar() {
//     if (manufacturer.isEmpty || type == null) {
//       print("Manufacturer and types must not be empty");
//       return Future.error("Manufacturer and types must not be empty");
//     }

//     // Call the cars CollectionReference to add a new car
//     return _carsCollection
//         .add({
//           'manufacturer': manufacturer.toString(),
//           'types': type.toString(),
//         })
//         .then((value) => print("Car added"))
//         .catchError((error) => print("Failed to add car: $error"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text('פירסום מודעה חדשה '),
//         ]),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               const SizedBox(
//                 height: 100,
//               ),
//               const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 SizedBox(
//                   width: 290,
//                 ),
//                 Text(
//                   "יצרן",
//                   style: TextStyle(fontSize: 19),
//                 ),
//               ]),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 350,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color.fromARGB(255, 240, 239, 239)
//                               .withOpacity(0.4),
//                           blurRadius: 30,
//                           spreadRadius: 1,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(10),
//                       border:
//                           Border.all(width: 1, color: const Color(0xff252527)),
//                     ),
//                     child: DropdownButton(
//                       underline: const Divider(
//                         thickness: 0,
//                         color: Colors.white,
//                       ),
//                       isExpanded: true,
//                       hint: const SizedBox(
//                           width: double.infinity,
//                           child: Text(
//                             "בחירת סוג רכב",
//                             textDirection: TextDirection.rtl,
//                           )),
//                       items: [
//                         " BMW",
//                         " audi ",
//                         "skoda ",
//                         " seat ",
//                         "VW ",
//                         " honda "
//                       ]
//                           .map((e) => DropdownMenuItem(
//                                 value: e,
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Text("$e"),
//                                 ),
//                               ))
//                           .toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           manufacturer = val;
//                         });
//                         print("aaaaaaaaaa----$manufacturer");
//                       },
//                       value: manufacturer,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 SizedBox(
//                   width: 290,
//                 ),
//                 Text(
//                   "דגם",
//                   style: TextStyle(fontSize: 19),
//                 ),
//               ]),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 350,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border:
//                           Border.all(width: 1, color: const Color(0xff252527)),
//                     ),
//                     child: DropdownButton(
//                       underline: const Divider(
//                         thickness: 0,
//                         color: Colors.white,
//                       ),
//                       isExpanded: true,
//                       hint: const SizedBox(
//                           width: double.infinity,
//                           child: Text(
//                             "בחירת דגם",
//                             textDirection: TextDirection.rtl,
//                           )),
//                       items: CarType.values
//                           .map((e) => DropdownMenuItem<CarType>(
//                                 value: type,
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Text(
//                                     type.toString().split('.').last,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           type = val as CarType?;
//                         });
//                       },
//                       value: type,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.only(left: 30.0, right: 30.0),
//                       child: Divider(
//                         color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
//                         height: 36,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     width: 130,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(9),
//                       border:
//                           Border.all(width: 1, color: const Color(0xff252527)),
//                     ),
//                     child: DropdownButton(
//                       underline: const Divider(
//                         thickness: 0,
//                         color: Colors.white,
//                       ),
//                       isExpanded: true,
//                       hint: SizedBox(
//                           width: double.infinity,
//                           child: Text(
//                             " 1971",
//                             style:
//                                 TextStyle(color: Colors.black.withOpacity(0.4)),
//                             textDirection: TextDirection.rtl,
//                           )),
//                       items: []
//                           .map((e) => DropdownMenuItem(
//                                 value: e,
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Text("$e"),
//                                 ),
//                               ))
//                           .toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           from = val;
//                         });
//                       },
//                       value: from,
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: Divider(
//                         color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
//                         height: 36,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     width: 130,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       border:
//                           Border.all(width: 1, color: const Color(0xff252527)),
//                       borderRadius: BorderRadius.circular(9),
//                     ),
//                   ),
//                 ],
//               ),
//               TextButton(
//                   onPressed: addCar, child: const Text('add to Collection')),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
