import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onButtonPressed(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Button Pressed!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome to MarketMirror!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _onButtonPressed(context),
                child: Text('Click Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
