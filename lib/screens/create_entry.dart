import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../services/data_service.dart';
import '../models/diary_entry.dart';

class CreateEntryScreen extends StatefulWidget {
  @override
  _CreateEntryScreenState createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _selectedMood;

  final List<String> moods = ['Glücklich', 'Traurig', 'Aufgeregt', 'Ruhig'];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final diaryId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuen Eintrag erstellen'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImagePicker(context),

                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Text(
                  'Beschreibung des Tages',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Erzähle von dem Tag',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.teal.withOpacity(0.05),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Die Beschreibung darf nicht leer sein.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  'Stimmung des Hundes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedMood,
                  items: moods
                      .map((mood) => DropdownMenuItem(
                    value: mood,
                    child: Text(mood),
                  ))
                      .toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.teal.withOpacity(0.05),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedMood = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Bitte eine Stimmung auswählen.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _selectedImage != null) {
                        _saveEntry(context, diaryId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bitte alle Felder ausfüllen und ein Bild hochladen.'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Speichern',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bild des Tages',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Center(
          child: _selectedImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              _selectedImage!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          )
              : Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.image,
              size: 60,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _selectedImage = File(pickedFile.path);
                });
              }
            },
            icon: const Icon(Icons.upload),
            label: const Text('Bild auswählen'),
          ),
        ),
      ],
    );
  }

  void _saveEntry(BuildContext context, String diaryId) {
    final newEntry = DiaryEntry(
      id: const Uuid().v4(),
      diaryId: diaryId,
      description: _descriptionController.text,
      mood: _selectedMood!,
      imagePath: _selectedImage!.path,
      createdAt: DateTime.now(),
    );

    context.read<DataService>().addEntry(newEntry);
    Navigator.pop(context);
  }
}
