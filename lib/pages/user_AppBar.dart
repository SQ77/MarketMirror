import 'package:flutter/material.dart';

class UserAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppbar({super.key});

  void _checkProfile() {
    // You can handle profile logic here
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 212, 181, 212),
      title: const Text("MARKET MIRROR"),
      actions: [
        IconButton(
          onPressed: _checkProfile,
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
