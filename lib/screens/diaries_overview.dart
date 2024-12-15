import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dog.dart';
import '../services/data_service.dart';
import '../utils/dialog_utils.dart';
import '../utils/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';
import '../generated/l10n.dart'; // Import for localization
import '../constants/routes_constants.dart';
import '../widgets/restart.dart';

class DiariesOverviewScreen extends StatelessWidget {
  const DiariesOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataService = context.watch<DataService>();
    final diaries = dataService.diaries;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: diaries.isEmpty ? _buildEmptyState(context) : _buildDiaryList(context, dataService, diaries),
      floatingActionButton: _buildFloatingActionButton(context),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.current.appTitle, style: TextStyles.appBarTitle),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => _showSettingsDialog(context),
        ),
      ],
    );
  }

  Center _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        S.current.noDiaries, // "No diaries available"
        style: TextStyles.emptyState,
      ),
    );
  }

  Padding _buildDiaryList(BuildContext context, DataService dataService, List<dynamic> diaries) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        itemCount: diaries.length,
        itemBuilder: (ctx, index) {
          final diary = diaries[index];
          return _buildDiaryCard(context, dataService, diary);
        },
      ),
    );
  }

  Card _buildDiaryCard(BuildContext context, DataService dataService, dynamic diary) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: diary.imagePath != null && File(diary.imagePath!).existsSync()
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(
            File(diary.imagePath!),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: 60,
            height: 60,
            color: Colors.grey[300],
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        ),
        title: Text(diary.title, style: TextStyles.cardTitle),
        subtitle: Text(
          '${S.current.boundTo}: ${_getDogName(dataService, diary.dogId)}\n'
              '${S.current.createdOn}: ${diary.createdAt.toLocal().toString().split(' ')[0]}',
          style: TextStyles.cardSubtitle,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            DialogUtils.showConfirmationDialog(
              context,
              title: S.current.deleteDiary,
              content: S.current.deleteDiaryConfirmation,
              onConfirm: () {
                context.read<DataService>().deleteDiary(diary.id);
              },
            );
          },
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteConstants.entryDetails,
            arguments: diary.id,
          );
        },
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.createDiary);
      },
      backgroundColor: Colors.black,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  String _getDogName(DataService dataService, String dogId) {
    final Dog dog = dataService.dogs.firstWhere(
          (dog) => dog.id == dogId,
      orElse: () => Dog(id: '', name: S.current.unknownDog, breed: '', birthDate: ''),
    );
    return dog.name;
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(S.current.settingsTitle, style: TextStyles.cardTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(S.current.changeLanguage),
                onTap: () => _showLanguageSelector(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(S.current.copyright),
                onTap: () {
                  Navigator.pop(ctx); // Close the dialog
                  DialogUtils.showInfoDialog(
                    context,
                    title: S.current.copyright,
                    content: 'Leon Burghardt © 2024',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(S.current.changeLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text('English'),
                onTap: () {
                  // Change language to English
                  S.load(const Locale('en'));
                  RestartWidget.restartApp(context);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text('Deutsch'),
                onTap: () {
                  // Change language to German
                  S.load(const Locale('de'));
                  RestartWidget.restartApp(context);
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
