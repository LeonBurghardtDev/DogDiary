import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../models/diary.dart';

class DiaryDetailsScreen extends StatelessWidget {
  const DiaryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Argumente aus der Route abrufen
    final String diaryId = ModalRoute.of(context)!.settings.arguments as String;

    final dataService = context.watch<DataService>();
    final diary = dataService.diaries.firstWhere((d) => d.id == diaryId);
    final entries = dataService.getDiaries(diary.dogId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tagebuch: ${diary.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _editDiary(context, diary);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageUploader(context, diary),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Titel: ${diary.title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Erstellt am: ${diary.createdAt.toLocal().toString().split(' ')[0]}',
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildEntryList(entries),
            const Divider(),
            _buildNewEntryButton(context, diaryId),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploader(BuildContext context, Diary diary) {
    return Center(
      child: Column(
        children: [
          diary.imagePath != null
              ? Image.file(
            File(diary.imagePath!),
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          )
              : Image.asset(
            'assets/placeholder.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // Bild hochladen (später zu implementieren)
            },
            icon: const Icon(Icons.upload),
            label: const Text('Bild hochladen'),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryList(List<Diary> entries) {
    if (entries.isEmpty) {
      return const Center(
        child: Text('Keine Einträge vorhanden.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (ctx, index) {
        final entry = entries[index];
        return ListTile(
          title: Text('Tag ${index + 1}'),
          subtitle: Text('Beschreibung: ${entry.title}'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(
              ctx,
              '/entry-details',
              arguments: entry.id, // Weiterleitung mit Argument
            );
          },
        );
      },
    );
  }

  Widget _buildNewEntryButton(BuildContext context, String diaryId) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/create-entry',
            arguments: diaryId,
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Neuen Eintrag hinzufügen'),
      ),
    );
  }

  void _editDiary(BuildContext context, Diary diary) {
    showDialog(
      context: context,
      builder: (ctx) {
        final TextEditingController titleController =
        TextEditingController(text: diary.title);
        return AlertDialog(
          title: const Text('Tagebuch bearbeiten'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Titel'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                // Tagebuch aktualisieren (später zu implementieren)
                Navigator.of(ctx).pop();
              },
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }
}
