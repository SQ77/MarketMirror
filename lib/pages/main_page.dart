import 'package:flutter/material.dart';
import 'package:marketmirror/pages/news/best_page.dart';
import 'package:marketmirror/pages/news/trending_page.dart';
import 'package:marketmirror/pages/news/financial_page.dart';
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

  List<String> pages = ["trending", "best", "hottest"];

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
        case 'hottest':
          defaultPage = FinancialPage();
          break;
        case 'best':
          defaultPage = BestPage();
          break;
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
          BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: "Best"),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: "Hottest",
          ),
        ],
      ),
    );
  }
}
