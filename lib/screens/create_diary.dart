import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/diary.dart';
import '../models/dog.dart';
import '../services/data_service.dart';

class CreateDiaryScreen extends StatefulWidget {
  @override
  _CreateDiaryScreenState createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dogNameController = TextEditingController();
  final _dogBreedController = TextEditingController();
  final _dogBirthDateController = TextEditingController();
  final _diaryTitleController = TextEditingController();

  File? _selectedImage;

  @override
  void dispose() {
    _dogNameController.dispose();
    _dogBreedController.dispose();
    _dogBirthDateController.dispose();
    _diaryTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuen Hund und Tagebuch erstellen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tagebuch Titel',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _diaryTitleController,
                  label: 'Titel des Tagebuchs',
                  hint: 'Gib den Titel ein',
                ),
                const SizedBox(height: 16),
                _buildImagePicker(),
                const SizedBox(height: 16),
                const Text(
                  'Hundedaten',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _dogNameController,
                  label: 'Name des Hundes',
                  hint: 'Gib den Namen ein',
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _dogBreedController,
                  label: 'Rasse des Hundes',
                  hint: 'Gib die Rasse ein',
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _dogBirthDateController,
                  label: 'Geburtsdatum des Hundes',
                  hint: 'Gib das Geburtsdatum ein (yyyy-mm-dd)',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Das Geburtsdatum darf nicht leer sein.';
                    }
                    final date = DateTime.tryParse(value);
                    if (date == null) {
                      return 'Ungültiges Datum. Verwende das Format yyyy-mm-dd.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _selectedImage != null) {
                      _saveDogAndDiary(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bitte ein Bild hochladen.')),
                      );
                    }
                  },
                  child: const Text('Speichern'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bild hochladen
  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bild hochladen',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _selectedImage != null
            ? Image.file(
          _selectedImage!,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        )
            : const Text('Kein Bild ausgewählt'),
        const SizedBox(height: 8),
        ElevatedButton.icon(
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
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      keyboardType: keyboardType,
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return '$label darf nicht leer sein.';
        }
        return null;
      },
    );
  }

  void _saveDogAndDiary(BuildContext context) {
    final dog = Dog(
      id: const Uuid().v4(),
      name: _dogNameController.text,
      breed: _dogBreedController.text,
      birthDate: DateTime.parse(_dogBirthDateController.text),
    );

    final diary = Diary(
      id: const Uuid().v4(),
      dogId: dog.id,
      title: _diaryTitleController.text,
      createdAt: DateTime.now(),
      imagePath: _selectedImage!.path,
    );

    final dataService = context.read<DataService>();
    dataService.addDog(dog);
    dataService.addDiary(diary);

    Navigator.pop(context);
  }
}
