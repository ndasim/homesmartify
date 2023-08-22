import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:homesmartify/domain/entities/routine.dart';
import 'package:homesmartify/presentation/pages/devices_page.dart';
import 'package:homesmartify/presentation/pages/routines_page.dart';

class RootPage extends StatefulWidget {
  RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController pageController = PageController(initialPage: 1);
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // TODO: This is a temporary solution for icon size
    double iconSize = themeData.iconTheme.size ?? 24.0;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: const [
          DevicesPage(),
          RoutinesPage()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: iconSize,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        index: currentPage,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.devices_other_rounded),
            label: 'Devices',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.av_timer_rounded),
            label: 'Routines',
          ),
        ],
        onTap: (index) {
          currentPage = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
