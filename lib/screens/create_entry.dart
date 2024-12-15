import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../generated/l10n.dart';
import '../models/diary_entry.dart';
import '../services/data_service.dart';
import '../utils/dialog_utils.dart';
import '../utils/text_styles.dart';
import '../utils/dialog_utils.dart';

class CreateEntryScreen extends StatefulWidget {
  @override
  _CreateEntryScreenState createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _selectedMood;

  final List<String> moods = ['happy', 'sad', 'excited', 'calm'];

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
        title: Text(S.of(context).newEntryTitle, style: TextStyles.appBarTitle),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(context),
              const SizedBox(height: 20),
              _buildSectionTitle(S.of(context).descriptionTitle),
              _buildDescriptionField(),
              const SizedBox(height: 20),
              _buildSectionTitle(S.of(context).moodTitle),
              _buildMoodDropdown(),
              const SizedBox(height: 30),
              _buildSaveButton(context, diaryId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyles.cardTitle);
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: S.of(context).descriptionHint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      maxLines: 4,
      validator: (value) =>
      value == null || value.isEmpty ? S.of(context).descriptionError : null,
    );
  }

  Widget _buildMoodDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedMood,
      items: moods.map((mood) {
        return DropdownMenuItem<String>(
          value: mood,
          child: Text(
            mood, // Display the actual mood string here
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      })
          .toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      onChanged: (value) => setState(() => _selectedMood = value),
      validator: (value) =>
      value == null ? S.of(context).moodError : null,
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(S.of(context).imageTitle),
        const SizedBox(height: 8),
        Center(
          child: _selectedImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(_selectedImage!,
                height: 200, width: 200, fit: BoxFit.cover),
          )
              : Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(Icons.image, size: 60),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.upload),
            label: Text(S.of(context).selectImage),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, String diaryId) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate() && _selectedImage != null) {
            _saveEntry(context, diaryId);
          } else {
            DialogUtils.showSnackbar(context, S.of(context).fillAllFields);
          }
        },
        icon: const Icon(Icons.save),
        label: Text(S.of(context).save),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
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
