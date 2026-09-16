import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/tabs/favorite_tab.dart';
import 'package:untitled1/tabs/home_tab.dart';
import 'package:untitled1/tabs/profile_tab.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0 ;
  List<Widget> tabsList = [
    HomeTab() ,
    FavoriteTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: [
          buildBottomNavItem(selectedIcon: Icon(Icons.home),
              unSelectedIcon: Icon(Icons.home_outlined),
              label: 'home_nav_home'.tr(),
              isSelected: selectedIndex == 0 ),
          buildBottomNavItem(selectedIcon: Icon(Icons.favorite),
                unSelectedIcon: Icon(Icons.favorite_border_outlined),
                label: 'home_nav_favorite'.tr(),
                isSelected: selectedIndex == 1 ),

          buildBottomNavItem(selectedIcon: Icon(Icons.person),
                unSelectedIcon: Icon(Icons.person_outline_outlined),
                label: 'home_nav_profile'.tr(),
                isSelected: selectedIndex == 2 )
          ],
        currentIndex: selectedIndex,
        onTap: (index) {
         selectedIndex= index;
       setState(() {

       });
       },
      ),
      body: tabsList[selectedIndex],
      floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
      },
        child: Icon(Icons.add,color: AppColors.whiteColor,size: 35,),
      ),
    );
  }
  BottomNavigationBarItem buildBottomNavItem({
    required Widget selectedIcon ,
    required Widget unSelectedIcon,
    required String label,
    required bool isSelected,
}
      ){
    return BottomNavigationBarItem(
        icon: isSelected ? selectedIcon :unSelectedIcon,
    label: label
    );
  }
}
