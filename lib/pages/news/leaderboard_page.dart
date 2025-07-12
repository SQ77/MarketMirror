import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  final List<String> entries = const <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(237, 57, 101, 221),
          padding: const EdgeInsets.all(16),
          child: const Text("I'm number 1", style: TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(12),
                color: const Color.fromARGB(240, 169, 117, 218),
                child: Center(child: Text('Entry ${entries[index]}')),
              );
            },
          ),
        ),
      ],
    );
  }
}
