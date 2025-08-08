import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding : const EdgeInsets.only(right: 30, left: 30),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 200),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(labelText: 'Body'),
              ),
              SizedBox(height: 40),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Submit Query"),
              ),
            ]
          ) 
        )
      )
    );
  }
}
