import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dog.dart';
import '../services/data_service.dart';

class DiariesOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Abrufen der Tagebücher aus dem DataService
    final dataService = context.watch<DataService>();
    final diaries = dataService.diaries;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagebuch Übersicht'),
      ),
      body: diaries.isEmpty
          ? const Center(
        child: Text('Noch keine Tagebücher vorhanden.'),
      )
          : ListView.builder(
        itemCount: diaries.length,
        itemBuilder: (ctx, index) {
          final diary = diaries[index];
          return ListTile(
            title: Text(diary.title),
            subtitle: Text(
              'Gebunden an: ${_getDogName(dataService, diary.dogId)}\n'
                  'Erstellt am: ${diary.createdAt.toLocal().toString().split(' ')[0]}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteDiary(context, diary.id);
              },
            ),
            onTap: () {
              // Navigation zu den Einträgen des Tagebuchs
              Navigator.pushNamed(
                context,
                '/entry-details',
                arguments: diary.id,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/create-diary',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Helferfunktion: Gibt den Namen des Hundes zurück, zu dem das Tagebuch gehört
  String _getDogName(DataService dataService, String dogId) {
    final dog = dataService.dogs.firstWhere(
          (dog) => dog.id == dogId,
    );
    return dog?.name ?? 'Unbekannter Hund';
  }

  /// Helferfunktion: Löscht ein Tagebuch mit Bestätigungsdialog
  void _deleteDiary(BuildContext context, String diaryId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tagebuch löschen'),
        content: const Text('Möchten Sie dieses Tagebuch wirklich löschen?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Dialog schließen
            },
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              context.read<DataService>().deleteDiary(diaryId);
              Navigator.of(ctx).pop(); // Dialog schließen
            },
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
  }
}
