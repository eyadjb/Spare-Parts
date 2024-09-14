// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:spareparts/navigationPages/SharePostNav/sharePost.dart';

// import '../navigationPages/SharePostNav/SharePostIfNotLogIn.dart';

// enum RoutePath {
//   initial(path: '/'),
//   SharePost(path: 'sharepost'),
//   SharePostIfNotLogIn(path: 'SharePostIfNotLogIn');

//   const RoutePath({required this.path});
//   final String path;
// }

// final goRouteProvider = Provider<GoRouter>((ref) {
//   return GoRouter(redirect: (context, state) {}, routes: [
//     GoRoute(
//         path: RoutePath.initial.path,
//         name: RoutePath.initial.name,
//         pageBuilder: (context, state) => MaterialPage(child: SharePost()),
//         routes: [
//           GoRoute(
//             path: RoutePath.initial.path,
//             name: RoutePath.initial.name,
//             pageBuilder: (context, state) =>
//                 MaterialPage(child: SharePostIfNotLogIn()),
//           )
//         ])
//   ]);
// });
