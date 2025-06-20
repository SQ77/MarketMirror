import 'package:flutter/material.dart';
import 'package:marketmirror/pages/userAppBar/user_profile.dart';

class UserAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      ),
      title: const Text("Market Mirror"),
      actions: [const UserProfile()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
