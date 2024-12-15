import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dog.dart';
import '../services/data_service.dart';
import '../widgets/bottom_nav_bar.dart';

class DiariesOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve diaries from the DataService
    final dataService = context.watch<DataService>();
    final diaries = dataService.diaries;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DogDiary',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: diaries.isEmpty
          ? const Center(
        child: Text(
          'Noch keine Tagebücher vorhanden.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          itemCount: diaries.length,
          itemBuilder: (ctx, index) {
            final diary = diaries[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  diary.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Gebunden an: ${_getDogName(dataService, diary.dogId)}\n'
                      'Erstellt am: ${diary.createdAt.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteDiary(context, diary.id);
                  },
                ),
                onTap: () {
                  // Navigate to diary details
                  Navigator.pushNamed(
                    context,
                    '/entry-details',
                    arguments: diary.id,
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/create-diary',
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  /// Helper function: Get the name of the dog linked to the diary
  String _getDogName(DataService dataService, String dogId) {
    final dog = dataService.dogs.firstWhere(
          (dog) => dog.id == dogId,
    );
    return dog.name;
  }

  /// Helper function: Delete a diary with a confirmation dialog
  void _deleteDiary(BuildContext context, String diaryId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Tagebuch löschen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Möchten Sie dieses Tagebuch wirklich löschen?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: const Text(
              'Abbrechen',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              context.read<DataService>().deleteDiary(diaryId);
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: const Text('Löschen', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
