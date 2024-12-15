import 'dart:io';

import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import 'package:dog_diary/generated/l10n.dart';

class DialogUtils {
  static void showConfirmationDialog(BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              onConfirm();
              Navigator.of(ctx).pop();
            },
            child: Text(S.of(context).delete, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showEditDialog({
    required BuildContext context,
    required String title,
    required String label,
    required TextEditingController controller,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.of(ctx).pop();
            },
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }

  static void showEntryDetails(BuildContext context, DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(S.of(context).entryDetails, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.file(
                  File(entry.imagePath),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              _buildDetailRow(context, S.of(context).description, entry.description),
              _buildDetailRow(context, S.of(context).mood, entry.mood),
              _buildDetailRow(
                context,
                S.of(context).createdAt,
                entry.createdAt.toLocal().toString().split(' ')[0],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context).close),
          ),
        ],
      ),
    );
  }

  static Widget _buildDetailRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  static void showInfoDialog(
      BuildContext context, {
        required String title,
        required String content,
      }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
