import 'package:flutter/material.dart';
import 'package:marketmirror/pages/news/best_page.dart';
import 'package:marketmirror/pages/news/trending_page.dart';
import 'package:marketmirror/pages/news/financial_page.dart';
import 'package:marketmirror/pages/userAppBar/user_appbar.dart';
import 'package:marketmirror/pages/userAppBar/user_navigationdrawer.dart';
import 'package:marketmirror/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
    const TrendingPage(),
    const BestPage(),
    const HottestPage(),
  ];

  int currentPage = 0;

  void _showChatTab() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: const UserAppbar(),
      drawer: const UserNavigationdrawer(),
      body: pages[currentPage],
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
