import 'package:flutter/material.dart';
import 'package:marketmirror/pages/userAppBar/user_profile.dart';

class UserAppbar extends StatelessWidget implements PreferredSizeWidget {

  final void Function(String) onMenuSelected;

  const UserAppbar({super.key, required this.onMenuSelected});

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
      actions: [UserProfile(changeMenu : onMenuSelected)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
