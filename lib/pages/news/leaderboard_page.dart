import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  final List<String> entries = const <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1, 
          child: Container(
            width: double.infinity,
            color: const Color.fromARGB(237, 57, 101, 221),
            alignment: Alignment.center,
            child: const Text(
              "I'm number 1",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          flex: 2, 
          child: Container(
            color: Color.fromARGB(255, 63, 63, 218),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
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
            ),) 
          )
        ),
      ],
    );
  }
}
