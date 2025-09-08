import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/utils/colors.dart';
import 'package:reps_trainer_app/views/playbook/playbook.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     
      home: BottomNavScreen(),
      getPages: [
        // other screens navigation
      ],
    );
  }
}

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;


  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class BottomNavScreen extends StatelessWidget {
  final List<Widget> _pages = [
    Center(child: Text('Dashboard', style: TextStyle(color: textColor),)),
    Center(child: Text('Stats', style: TextStyle(color: textColor),)),
    //Center(child: Text('Plans', style: TextStyle(color: textColor),)),
    PlaybookScreen(),
    Center(child: Text('Players', style: TextStyle(color: textColor),)),
    Center(child: Text('Profile', style: TextStyle(color: textColor),)),
  ];

   BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: backgroundColor,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: textColor,
          items: [
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 0?Image.asset('assets/icons/dashboard_s.png'):Image.asset('assets/icons/dashboard.png'),
              label: '',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 1?Image.asset('assets/icons/stats_s.png'):Image.asset('assets/icons/stats.png'),
              label: '',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 2? Image.asset('assets/icons/plans_s.png'): Image.asset('assets/icons/plans.png'),
              label: '',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 3?Image.asset('assets/icons/players_s.png'):Image.asset('assets/icons/players.png'),
              label: '',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 4?Image.asset('assets/icons/profile_s.png'):Image.asset('assets/icons/profile.png'),
              label: '',
              backgroundColor: backgroundColor
            ),
          ],
        ),
      ),
    );
  }
}