import 'package:flutter/material.dart';
import 'package:marketmirror/pages/main_page.dart';

class UserNavigationdrawer extends StatelessWidget {
  const UserNavigationdrawer({super.key});

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
      leading: const Icon(Icons.home_outlined),
      title: const Text("Home"),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
      },
    ),
    ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("Settings"),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
      },
    ),
    ListTile(
      leading: const Icon(Icons.support),
      title: const Text("Contact us"),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
      },
    ),
  ],
);
