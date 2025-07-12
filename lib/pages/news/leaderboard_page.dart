import 'package:flutter/material.dart';
import 'package:flutter_podium/flutter_podium.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  final List<String> entries = const <String>['A', 'B', 'C', 'A', 'B', 'C', 'A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
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
                      margin: EdgeInsets.all(10),
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
