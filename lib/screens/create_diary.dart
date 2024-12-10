import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/diary.dart';
import '../models/dog.dart';
import '../services/data_service.dart';

/// Screen to create a new diary and a new dog simultaneously.
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
                    if (_formKey.currentState!.validate()) {
                      _saveDogAndDiary(context);
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

  /// Helper method to build text fields with validation.
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

  /// Saves a new dog and a linked diary, then navigates back to the previous screen.
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
    );

    final dataService = context.read<DataService>();
    dataService.addDog(dog);
    dataService.addDiary(diary);

    Navigator.pop(context);
  }
}
