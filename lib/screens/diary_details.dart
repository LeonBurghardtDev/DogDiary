import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/diary_entry.dart';
import '../services/data_service.dart';
import '../models/diary.dart';
import '../generated/l10n.dart'; // Localization
import '../utils/text_styles.dart';
import '../utils/dialog_utils.dart';

class DiaryDetailsScreen extends StatelessWidget {
  const DiaryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String diaryId = ModalRoute.of(context)!.settings.arguments as String;

    final dataService = context.watch<DataService>();
    final diary = dataService.diaries.firstWhere((d) => d.id == diaryId);
    final entries = dataService.getEntries(diaryId);

    return Scaffold(
      appBar: _buildAppBar(context, diary),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageUploader(context, diary, dataService),
              const SizedBox(height: 20),
              _buildDiaryInfo(context, diary),
              const SizedBox(height: 20),
              _buildSectionTitle(context, S.of(context).entries),
              const SizedBox(height: 10),
              _buildEntryList(context, entries),
              const SizedBox(height: 20),
              _buildNewEntryButton(context, diaryId),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Diary diary) {
    return AppBar(
      title: Text(diary.title, style: TextStyles.appBarTitle),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.black),
          onPressed: () => _editDiary(context, diary),
        ),
      ],
    );
  }

  Widget _buildImageUploader(BuildContext context, Diary diary, DataService dataService) {
    return Center(
      child: Column(
        children: [
          _buildImageDisplay(diary),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final updatedDiary = diary.copyWith(imagePath: pickedFile.path);
                dataService.updateDiary(updatedDiary);
              }
            },
            icon: const Icon(Icons.upload),
            label: Text(S.of(context).changeImage),
          ),
        ],
      ),
    );
  }

  Widget _buildImageDisplay(Diary diary) {
    return diary.imagePath != null
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
      child: const Icon(Icons.image, size: 80, color: Colors.grey),
    );
  }

  Widget _buildDiaryInfo(BuildContext context, Diary diary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${S.of(context).title}: ${diary.title}', style: TextStyles.cardTitle),
        const SizedBox(height: 8),
        Text(
          '${S.of(context).createdAt}: ${DateFormat('dd.MM.yyyy').format(diary.createdAt)}',
          style: TextStyles.cardSubtitle,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEntryList(BuildContext context, List<DiaryEntry> entries) {
    if (entries.isEmpty) {
      return Center(
        child: Text(S.of(context).noEntries, style: TextStyles.emptyState),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (ctx, index) => _buildEntryCard(context, entries[index]),
    );
  }

  Card _buildEntryCard(BuildContext context, DiaryEntry entry) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(File(entry.imagePath), width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(entry.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text('${S.of(context).mood}: ${entry.mood}'),
        trailing: Text(DateFormat('dd.MM.yyyy').format(entry.createdAt)),
        onTap: () => DialogUtils.showEntryDetails(context, entry),
      ),
    );
  }

  Widget _buildNewEntryButton(BuildContext context, String diaryId) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/create-entry', arguments: diaryId),
        icon: const Icon(Icons.add),
        label: Text(S.of(context).addNewEntry),
      ),
    );
  }

  void _editDiary(BuildContext context, Diary diary) {
    final TextEditingController titleController = TextEditingController(text: diary.title);
    DialogUtils.showEditDialog(
      context: context,
      title: S.of(context).editDiaryTitle,
      label: S.of(context).title,
      controller: titleController,
      onConfirm: () {
        final updatedDiary = diary.copyWith(title: titleController.text);
        context.read<DataService>().updateDiary(updatedDiary);
      },
    );
  }
}
