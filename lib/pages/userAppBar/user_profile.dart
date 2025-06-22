import 'package:flutter/material.dart';
import 'package:marketmirror/auth/auth_service.dart';

class UserProfile extends StatefulWidget {
  final void Function(String) changeMenu;

  const UserProfile({super.key, required this.changeMenu});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService _authService = AuthService();

  Future<void> _signOut() async {
    try {
      await _authService.signOut();
      // AuthGate handles redirection
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign out failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _showAccountDetails() {
    widget.changeMenu('account');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.person),
      onSelected: (String value) {
        switch (value) {
          case 'account':
            _showAccountDetails();
            break;
          case 'signout':
            _showSignOutDialog();
            break;
        }
      },
      itemBuilder:
          (context) => [
            const PopupMenuItem(
              value: 'account',
              child: Text("Account Settings"),
            ),
            PopupMenuItem(value: 'signout', child: const Text("Sign Out")),
          ],
    );
  }
}
