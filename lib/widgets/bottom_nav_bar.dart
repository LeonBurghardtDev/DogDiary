import 'package:flutter/material.dart';

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
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/blog');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/chats');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Tagebücher',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Blog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
