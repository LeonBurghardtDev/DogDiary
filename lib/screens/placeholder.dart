import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../generated/l10n.dart';

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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: BottomNavBar(currentIndex: currentIndex),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80), // Platz für die NavBar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Center(
                child: Text(
                  S.of(context).comingSoon(title),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildHomeButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/'),
      backgroundColor: Colors.black,
      child: const Icon(Icons.home, color: Colors.white),
    );
  }
}
