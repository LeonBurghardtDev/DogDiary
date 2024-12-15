import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/diary.dart';
import '../models/dog.dart';
import '../services/data_service.dart';
import '../generated/l10n.dart'; // Localization
import '../utils/text_styles.dart';

class CreateDiaryScreen extends StatefulWidget {
  const CreateDiaryScreen({Key? key}) : super(key: key);

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
      appBar: _buildAppBar(context),
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
                _buildSectionTitle(context, S.of(context).diaryTitle),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _diaryTitleController,
                  label: S.of(context).diaryTitleLabel,
                  hint: S.of(context).diaryTitleHint,
                ),
                const SizedBox(height: 20),
                _buildSectionTitle(context, S.of(context).dogDetails),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _dogNameController,
                  label: S.of(context).dogNameLabel,
                  hint: S.of(context).dogNameHint,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _dogBreedController,
                  label: S.of(context).dogBreedLabel,
                  hint: S.of(context).dogBreedHint,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _dogBirthDateController,
                  label: S.of(context).dogBirthDateLabel,
                  hint: S.of(context).dogBirthDateHint,
                  keyboardType: TextInputType.datetime,
                  validator: _validateDate,
                ),
                const SizedBox(height: 30),
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).createDiaryTitle),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, S.of(context).diaryCover),
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
              child: Icon(Icons.image, size: 60),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.upload),
            label: Text(S.of(context).chooseImage),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.teal.withOpacity(0.05),
        hintText: hint,
      ),
      keyboardType: keyboardType,
      validator: validator ?? (value) => value?.isEmpty ?? true ? label : null,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _saveDogAndDiary,
        icon: const Icon(Icons.save),
        label: Text(S.of(context).saveButton),
      ),
    );
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).birthDateEmptyError;
    }
    try {
      final date = DateFormat('dd.MM.yyyy').parse(value);
      if (date.isAfter(DateTime.now())) {
        return S.of(context).birthDateFutureError;
      }
    } catch (_) {
      return S.of(context).birthDateFormatError;
    }
    return null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _saveDogAndDiary() {
    if (_formKey.currentState?.validate() == true && _selectedImage != null) {
      final dog = Dog(
        id: const Uuid().v4(),
        name: _dogNameController.text,
        breed: _dogBreedController.text,
        birthDate: _dogBirthDateController.text,
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).missingFieldsError)),
      );
    }
  }
}
