import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthub_2/colors.dart';
import 'package:icthub_2/cubit/app_cubit.dart';
import 'package:icthub_2/cubit/profile_cubit.dart';
import 'package:icthub_2/screens/list_screen.dart';
import 'package:icthub_2/screens/profile_screen.dart';
import 'package:icthub_2/screens/search.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> listScreens = [
    const ListScreen(),
    SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListOfProductsCubit>(
          create: (context) => ListOfProductsCubit()..getProductsData(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..getUserDataFromFireStore(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        body: listScreens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.scaffold,
          unselectedItemColor: AppColors.hintTextX,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}