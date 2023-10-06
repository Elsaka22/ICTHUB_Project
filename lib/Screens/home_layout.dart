import 'package:flutter/material.dart';
import 'package:icthub_2/Screens/list_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int CurrentIndex = 0;
  List<Widget> listScreens =
      [
        ListScreen(),

      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListScreen(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueGrey,
        backgroundColor: Colors.white70,

        currentIndex: CurrentIndex,
        onTap: (index){

        },

        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'home'
          ), BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'search'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'profile'
          ),
        ],
      ),
    );
  }
}
