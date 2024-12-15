import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/diary_entry.dart';
import '../services/data_service.dart';
import '../models/diary.dart';

class DiaryDetailsScreen extends StatelessWidget {
  const DiaryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String diaryId = ModalRoute.of(context)!.settings.arguments as String;

    final dataService = context.watch<DataService>();
    final diary = dataService.diaries.firstWhere((d) => d.id == diaryId);
    final entries = dataService.getDiaries(diary.dogId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          diary.title,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () => _editDiary(context, diary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageUploader(context, diary, dataService),
              const SizedBox(height: 20),
              _buildDiaryInfo(diary),
              const SizedBox(height: 20),
              const Text(
                'Einträge',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildEntryList(dataService.getEntries(diaryId)),
              const SizedBox(height: 20),
              _buildNewEntryButton(context, diaryId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploader(BuildContext context, Diary diary, DataService dataService) {
    return Center(
      child: Column(
        children: [
          diary.imagePath != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              File(diary.imagePath!),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
              : Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 80, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
            onPressed: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final updatedDiary = diary.copyWith(imagePath: pickedFile.path);
                dataService.updateDiary(updatedDiary);
              }
            },
            icon: const Icon(Icons.upload),
            label: const Text('Bild ändern'),
          ),
        ],
      ),
    );
  }

  Widget _buildDiaryInfo(Diary diary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titel: ${diary.title}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Erstellt am: ${diary.createdAt.toLocal().toString().split(' ')[0]}',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildEntryList(List<DiaryEntry> entries) {
    if (entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Noch keine Einträge vorhanden.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (ctx, index) {
        final entry = entries[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(entry.imagePath),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              entry.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Stimmung: ${entry.mood}'),
            trailing: Text(
              entry.createdAt.toLocal().toString().split(' ')[0],
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              _showEntryPopup(ctx, entry); // Show popup when tapped
            },
          ),
        );
      },
    );
  }
  void _showEntryPopup(BuildContext context, DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Eintragsdetails',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ensure Image has valid size constraints
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    File(entry.imagePath),
                    width: MediaQuery.of(context).size.width * 0.8, // Adjust to screen width
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Beschreibung:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  entry.description,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  'Stimmung:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  entry.mood,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  'Erstellt am:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  entry.createdAt.toLocal().toString().split(' ')[0],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Schließen'),
            ),
          ],
        );
      },
    );
  }



  Widget _buildNewEntryButton(BuildContext context, String diaryId) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
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
            decoration: InputDecoration(
              labelText: 'Titel',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              onPressed: () {
                final updatedDiary = diary.copyWith(title: titleController.text);
                context.read<DataService>().updateDiary(updatedDiary);
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
