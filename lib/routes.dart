import 'package:dog_diary/screens/create_diary.dart';
import 'package:dog_diary/screens/diary_details.dart';
import 'package:flutter/material.dart';
import 'screens/diaries_overview.dart';
import 'screens/create_diary.dart';
//import 'screens/diary_overview.dart';
//import 'screens/create_entry.dart';
//import 'screens/view_entry.dart';

/// Defines the routes for navigation within the Dog Diary application.
final Map<String, WidgetBuilder> routes = {
  /// Home route: Displays the list of dogs.
  '/': (context) => DiariesOverviewScreen(),
  '/create-diary': (context) => CreateDiaryScreen(),
  '/entry-details': (context) => DiaryDetailsScreen(),

};
