import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/horizontal_divider.dart';
import '../chat/chat_screen.dart';
import '../connection/connection_screen.dart';
import '../home/home_screen.dart';
import '../marketplace/marketplace_screen.dart';
import '../more/more_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeScreen(),
    MarketplaceScreen(),
    ConnectionScreen(),
    ChatScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HorizontalDivider(),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Theme.of(
                  context,
                ).scaffoldBackgroundColor.withOpacity(0.8),
                child: BottomNavigationBar(
                  onTap: _onItemTapped,
                  backgroundColor: Colors.transparent,
                  currentIndex: _selectedIndex,
                  elevation: 0.0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.home),
                      activeIcon: Icon(Iconsax.home5),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.shop),
                      activeIcon: Icon(Iconsax.shop5),
                      label: 'Marketplace',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.personalcard),
                      activeIcon: Icon(Iconsax.personalcard5),
                      label: 'Connection',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.message),
                      activeIcon: Icon(Iconsax.message5),
                      label: 'Chats',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.more_2),
                      activeIcon: Icon(Iconsax.more_25),
                      label: 'More',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
