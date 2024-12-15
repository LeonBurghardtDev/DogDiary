import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final int currentIndex;

  const PlaceholderScreen({
    Key? key,
    required this.title,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80), // Platz für die NavBar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                Center(
                  child: Text(
                    '$title Seite kommt bald!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Dummy Content zum Scrollen
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/',
                    );
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.home, color: Colors.white),
                ),
              ],

            ),
          ),

        ],
      ),
    );
  }
}
