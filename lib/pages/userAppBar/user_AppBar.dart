import 'package:flutter/material.dart';
import 'package:marketmirror/pages/userAppBar/user_Profile.dart';

class UserAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppbar({super.key});

  void _checkProfile() {
    // Handle profile logic here
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 181, 212),
      title: const Text("MARKET MIRROR"),
      actions: [
        const UserProfile()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
