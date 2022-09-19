import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_tutorial/config/app_icons.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/screens/chat/chat.dart';
import 'package:firebase_tutorial/views/screens/contact/contact.dart';
import 'package:firebase_tutorial/views/screens/home/home.dart';
import 'package:firebase_tutorial/views/screens/profile/profile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 2;
  UserFunction userFunction = UserFunction();
  final nameController = TextEditingController();
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigation(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: const [
            HomeScreen(),
            ContactScreen(),
            ChatScreen(),
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          borderRadius: const Radius.circular(30),
          isFloating: true,
          items: [
            CustomNavigationBarItem(
                icon: currentIndex == 0
                    ? AppIcon.chatActive
                    : AppIcon.chatUnActive),
            CustomNavigationBarItem(
                icon: currentIndex == 1
                    ? AppIcon.contactActive
                    : AppIcon.contactUnActive),
            CustomNavigationBarItem(
                icon: currentIndex == 2
                    ? AppIcon.homeActive
                    : AppIcon.homeUnActive),
            CustomNavigationBarItem(
                icon: currentIndex == 3
                    ? AppIcon.notificationActive
                    : AppIcon.notificationUnActive),
            CustomNavigationBarItem(
                icon: currentIndex == 4
                    ? AppIcon.settingActive
                    : AppIcon.settingUnActive),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            if(currentIndex != index)
            {
              switch(index){
              case 0:
                navigation(2);
               break;
              case 1:
                navigation(1);
               break;
              case 2:
                navigation(0);
               break;
              case 3:
                navigation(3);
               break;
              case 4:
                navigation(4);
               break;
            }
            setState(() {
              currentIndex = index;
              print(index);
            
            });
            }
          },
        ),
      ),
    );
  }
}
