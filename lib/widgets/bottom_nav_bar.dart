import 'package:flutter/material.dart';
import '../constants/routes_constants.dart';
import '../generated/l10n.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      onTap: (index) => _onItemTapped(context, index),
      items: _buildNavigationItems(context),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    final routes = [
      RouteConstants.diariesOverview,
      RouteConstants.blog,
      RouteConstants.chats,
      RouteConstants.profile,
    ];

    if (index != currentIndex) {
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  List<BottomNavigationBarItem> _buildNavigationItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.book),
        label: S.of(context).navDiaries,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.article),
        label: S.of(context).navBlog,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.chat),
        label: S.of(context).navChats,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: S.of(context).navProfile,
      ),
    ];
  }
}
