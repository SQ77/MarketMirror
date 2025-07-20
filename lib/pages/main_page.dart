import 'package:flutter/material.dart';
import 'package:marketmirror/pages/news/predict_page.dart';
import 'package:marketmirror/pages/news/trending_page.dart';
import 'package:marketmirror/pages/news/financial_page.dart';
import 'package:marketmirror/pages/news/leaderboard_page.dart';
import 'package:marketmirror/pages/userAppBar/user_appbar.dart';
import 'package:marketmirror/pages/userAppBar/user_navigationdrawer.dart';
import 'package:marketmirror/pages/userAppBar/user_account.dart';
import 'package:marketmirror/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget defaultPage = const TrendingPage();

  List<String> pages = ["trending", "predict", "financial", "leaderboard"];

  int currentPage = 0;

  void _showChatTab() {
    return;
  }

  void _onMenuSelected(String value) {
    setState(() {
      switch (value) {
        case 'account':
          defaultPage = UserAccount();
          break;
        case 'trending':
          defaultPage = TrendingPage();
          break;
        case 'financial':
          defaultPage = FinancialPage();
          break;
        case 'predict':
          defaultPage = PredictPage();
          break;
        case 'leaderboard':
          defaultPage = LeaderboardPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: UserAppbar(onMenuSelected: _onMenuSelected),
      drawer: const UserNavigationdrawer(),
      body: defaultPage,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.message),
        onPressed: () => _showChatTab(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.surfaceColor,
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: AppTheme.textSecondary,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
            _onMenuSelected(pages[value]);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Trending",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.poll), label: "Predict"),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Financial",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard), 
            label: "Leaderboard",
          ),
        ],
      ),
    );
  }
}
