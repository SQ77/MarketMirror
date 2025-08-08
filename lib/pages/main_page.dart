import 'package:flutter/material.dart';
import 'package:marketmirror/pages/news/predict_page.dart';
import 'package:marketmirror/pages/news/trending_page.dart';
import 'package:marketmirror/pages/news/financial_page.dart';
import 'package:marketmirror/pages/news/leaderboard_page.dart';
import 'package:marketmirror/pages/userAppBar/user_appbar.dart';
import 'package:marketmirror/pages/userAppBar/user_navigation_drawer.dart';
import 'package:marketmirror/pages/userAppBar/user_account.dart';
import 'package:marketmirror/pages/account/settings_page.dart';
import 'package:marketmirror/pages/account/contact_page.dart';
import 'package:marketmirror/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.username});

  final String username;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget defaultPage = const TrendingPage();

  List<String> pages = [
    "trending",
    "predict",
    "financial",
    "leaderboard",
    "settings",
    "contact",
  ];

  int currentPage = 0;

  void _onMenuSelected(String value) {
    setState(() {
      switch (value) {
        case 'account':
          defaultPage = UserAccount(username: widget.username);
          break;

        case 'trending':
          defaultPage = TrendingPage();
          currentPage = 0;
          break;

        case 'predict':
          defaultPage = PredictPage(username: widget.username);
          currentPage = 1;
          break;

        case 'financial':
          defaultPage = FinancialPage();
          currentPage = 2;
          break;

        case 'leaderboard':
          defaultPage = LeaderboardPage();
          currentPage = 3;
          break;

        case 'settings':
          defaultPage = SettingsPage();
          break;

        case 'contact':
          defaultPage = ContactPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: UserAppbar(onMenuSelected: _onMenuSelected),
      drawer: UserNavigationdrawer(
        onMenuSelected: _onMenuSelected,
        username: widget.username,
      ),
      body: defaultPage,
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
