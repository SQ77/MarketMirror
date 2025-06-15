import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder:
          (context) => [
            PopupMenuItem(child: Text("Account Settings")),
            PopupMenuItem(child: Text("Sign Out")),
          ],
    );
  }
}
