import 'package:flutter/material.dart';

class UserNavigationdrawer extends StatelessWidget {
  const UserNavigationdrawer({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Container(
  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
);

Widget buildMenuItems(context) => Column(
  children: [
    ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("Settings"),
    ),
    ListTile(
      leading: const Icon(Icons.support),
      title: const Text("Contact us"),
    ),
  ],
);
