// ignore: unused_import
// ignore_for_file: file_names, unnecessary_import, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: use_key_in_widget_constructors
class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: Text('Eyad jbaren'),
          //   accountEmail: Text('eyadjbaren99@gmail.com'),
          //   currentAccountPicture: CircleAvatar(
          //       child: ClipOval(child: Image.asset('images/eyadpic.jpg'))),
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('images/background-login.jpeg'),
          //         fit: BoxFit.cover),
          //   ),
          // ),
          const DrawerHeader(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [Icon(Icons.garage)],
            ),
          ),
          ListTile(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'eyad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
            trailing: const Icon(
                Icons.favorite), // Change this line to change the icon
            onTap: () => print('eyad'),
          ),
          ListTile(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'eyad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
            trailing: const Icon(
                Icons.favorite), // Change this line to change the icon
            onTap: () => print('eyad'),
          ),
          ListTile(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'eyad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
            trailing: const Icon(
                Icons.favorite), // Change this line to change the icon
            onTap: () => print('eyad'),
          ),
          ListTile(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'eyad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
            trailing: const Icon(
                Icons.favorite), // Change this line to change the icon
            onTap: () => print('eyad'),
          ),
          ListTile(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'eyad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
            trailing: const Icon(
                Icons.favorite), // Change this line to change the icon
            onTap: () => print('eyad'),
          ),
        ],
      ),
    );
  }
}
