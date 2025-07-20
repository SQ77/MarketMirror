import 'package:flutter/material.dart';
import 'package:flutter_podium/flutter_podium.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  // Sample leaderboard data: names and scores
  final List<Map<String, dynamic>> leaderboardData = const [
    {'name': 'Alice', 'score': 120},
    {'name': 'Bob', 'score': 110},
    {'name': 'Charlie', 'score': 100},
    {'name': 'David', 'score': 95},
    {'name': 'Eva', 'score': 92},
    {'name': 'Frank', 'score': 89},
    {'name': 'Grace', 'score': 85},
    {'name': 'Hannah', 'score': 80},
    {'name': 'Ian', 'score': 77},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Podium for top 3
          Podium(
            firstPosition: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  leaderboardData[0]['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '${leaderboardData[0]['score']} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            secondPosition: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  leaderboardData[1]['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '${leaderboardData[1]['score']} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            thirdPosition: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  leaderboardData[2]['name'],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '${leaderboardData[2]['score']} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            color: const Color(0xFF00C896),
            rankingTextColor: Colors.white,
            rankingFontSize: 30,
            hideRanking: false,
            height: 250,
            width: 100,
            horizontalSpacing: 5,
            showRankingNumberInsteadOfText: true,
          ),

          const SizedBox(height: 20),

          // Remaining entries
          Expanded(
            child: ListView.builder(
              itemCount: leaderboardData.length - 3,
              itemBuilder: (BuildContext context, int index) {
                final actualIndex = index + 3;
                final entry = leaderboardData[actualIndex];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${actualIndex + 1}. ${entry['name']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${entry['score']} pts',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
