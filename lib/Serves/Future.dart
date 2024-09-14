// ignore_for_file: file_names
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:riverpod/riverpod.dart';

// FutureOr<String?> appRouteRedirect(
//     BuildContext context, Ref ref, GoRouterState state) async {
//   final user = ref.read(authRepositoryProvider).currentUser;
//   final isLoggedIn = user != null;
//   final isAttemptingSharePostIfNotLoggedIn =
//       !isLoggedIn && state.matchedLocation == 'SharePostIfNotLogIn';

//   if (isAttemptingSharePostIfNotLoggedIn) {
//     // Redirect to '/' route if the user is not logged in
//     return '/';
//   }

//   // No redirection needed
//   return null;
// }

