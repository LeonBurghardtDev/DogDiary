import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
        title: const Text('Neues Tagebuch erstellen'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImagePicker(),

                const SizedBox(height: 20),
                Text(
                  'Tagebuch Titel',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _diaryTitleController,
                  label: 'Titel des Tagebuchs',
                  hint: 'Gib den Titel des Tagebuchs ein',
                ),

                const SizedBox(height: 20),
                Text(
                  'Hundedaten',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _dogNameController,
                  label: 'Name des Hundes',
                  hint: 'Gib den Namen ein',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _dogBreedController,
                  label: 'Rasse des Hundes',
                  hint: 'Gib die Rasse ein',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _dogBirthDateController,
                  label: 'Geburtsdatum des Hundes',
                  hint: 'Gib das Geburtsdatum ein (dd.MM.yyyy)',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Das Geburtsdatum darf nicht leer sein.';
                    }
                    // Parse the input as a German-style date
                    try {
                      final date = DateFormat('dd.MM.yyyy').parse(value);
                      if (date.isAfter(DateTime.now())) {
                        return 'Das Datum darf nicht in der Zukunft liegen.';
                      }
                    } catch (e) {
                      return 'Ungültiges Format. Verwende dd.MM.yyyy.';
                    }
                    return null;
                  },
                ),


                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedImage != null) {
                        _saveDogAndDiary(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Bitte alle Felder ausfüllen und ein Bild hochladen.'),
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

  /// Image Picker for Diary Cover
  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titelbild des Tagebuchs',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Center(
          child: _selectedImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              _selectedImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
              : Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 60,
              ),
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
              final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.teal.withOpacity(0.05),
        hintText: hint,
      ),
      keyboardType: keyboardType,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return '$label darf nicht leer sein.';
            }
            return null;
          },
    );
  }

  void _saveDogAndDiary(BuildContext context) {
    try {
      // Datum im deutschen Format einlesen
      final String birthDateString = _dogBirthDateController.text;

      // Sicherstellen, dass das Format korrekt ist
      final DateTime birthDate = DateFormat('dd.MM.yyyy').parse(birthDateString);

      final dog = Dog(
        id: const Uuid().v4(),
        name: _dogNameController.text,
        breed: _dogBreedController.text,
        birthDate: birthDateString, // Im deutschen Format speichern
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fehler beim Speichern. Überprüfe die Eingaben.')),
      );
    }
  }


}
