import 'package:flutter/material.dart';

class UserNavigationdrawer extends StatelessWidget {

  final void Function(String) onMenuSelected;
  final String username;

  const UserNavigationdrawer({
    super.key, 
    required this.onMenuSelected, 
    required this.username
  });


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


  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: ListTile(
      leading: const Icon(Icons.person),
      title: Text(username)
    )
  );

  Widget buildMenuItems(context) => Column(
    children: [
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text("Settings"),
        onTap: () => onMenuSelected('settings'),
      ),
      ListTile(
        leading: const Icon(Icons.support),
        title: const Text("Contact us"),
        onTap: () => onMenuSelected('contact'),
      ),
    ],
  );
}


