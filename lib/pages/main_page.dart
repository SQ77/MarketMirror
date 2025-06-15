import 'package:flutter/material.dart';
import 'package:marketmirror/pages/news/best_page.dart';
import 'package:marketmirror/pages/news/trending_page.dart';
import 'package:marketmirror/pages/news/hottest_page.dart';
import 'package:marketmirror/pages/userAppBar/user_AppBar.dart';
import 'package:marketmirror/pages/userAppBar/user_NavigationDrawer.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppbar(),
      drawer: const UserNavigationdrawer(),
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
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
