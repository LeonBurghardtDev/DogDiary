import 'package:dog_diary/screens/create_diary.dart';
import 'package:dog_diary/screens/create_entry.dart';
import 'package:dog_diary/screens/diary_details.dart';
import 'package:dog_diary/screens/placeholder.dart';
import 'package:dog_diary/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'screens/diaries_overview.dart';


/// Defines the routes for navigation within the Dog Diary application.
final Map<String, WidgetBuilder> routes = {
  /// Home route: Displays the list of dogs.
  '/': (context) => DiariesOverviewScreen(),
  '/create-diary': (context) => CreateDiaryScreen(),
  '/entry-details': (context) => DiaryDetailsScreen(),
  '/create-entry': (context) => CreateEntryScreen(),
  '/blog': (context) => PlaceholderScreen(title: 'Blog', currentIndex: 1),
  '/chats': (context) => PlaceholderScreen(title: 'Chats', currentIndex: 2),
  '/profile': (context) => PlaceholderScreen(title: 'Profil', currentIndex: 3),

};
