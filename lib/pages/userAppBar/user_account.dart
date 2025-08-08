import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  final String username;

  const UserAccount({super.key, required this.username});

  void _changePassword() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Icon(Icons.person, size: 80),
              Text(username),
              SizedBox(height: 40),
              SizedBox(height: 40),
              Text("Change Password"),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Password'),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: _changePassword,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
