// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(title) => "${title} page is coming soon!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewEntry": MessageLookupByLibrary.simpleMessage("Add New Entry"),
        "appTitle": MessageLookupByLibrary.simpleMessage("DogDiary"),
        "birthDateEmptyError":
            MessageLookupByLibrary.simpleMessage("Birth date cannot be empty."),
        "birthDateFormatError": MessageLookupByLibrary.simpleMessage(
            "Invalid format. Use dd.MM.yyyy."),
        "birthDateFutureError": MessageLookupByLibrary.simpleMessage(
            "Date cannot be in the future."),
        "boundTo": MessageLookupByLibrary.simpleMessage("Bound to"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeImage": MessageLookupByLibrary.simpleMessage("Change Image"),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "chooseImage": MessageLookupByLibrary.simpleMessage("Choose Image"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "comingSoon": m0,
        "copyright": MessageLookupByLibrary.simpleMessage("Copyright"),
        "createDiaryTitle":
            MessageLookupByLibrary.simpleMessage("Create New Diary"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Created at"),
        "createdOn": MessageLookupByLibrary.simpleMessage("Created on"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteDiary": MessageLookupByLibrary.simpleMessage("Delete Diary"),
        "deleteDiaryConfirmation": MessageLookupByLibrary.simpleMessage(
            "Do you really want to delete this diary?"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "descriptionError": MessageLookupByLibrary.simpleMessage(
            "Description cannot be empty."),
        "descriptionHint":
            MessageLookupByLibrary.simpleMessage("Describe the day"),
        "descriptionTitle":
            MessageLookupByLibrary.simpleMessage("Day Description"),
        "diaryCover": MessageLookupByLibrary.simpleMessage("Diary Cover"),
        "diaryTitle": MessageLookupByLibrary.simpleMessage("Diary Title"),
        "diaryTitleHint":
            MessageLookupByLibrary.simpleMessage("Enter the diary title"),
        "diaryTitleLabel": MessageLookupByLibrary.simpleMessage("Title"),
        "dogBirthDateHint": MessageLookupByLibrary.simpleMessage(
            "Enter birth date (dd.MM.yyyy)"),
        "dogBirthDateLabel":
            MessageLookupByLibrary.simpleMessage("Dog\'s Birth Date"),
        "dogBreedHint":
            MessageLookupByLibrary.simpleMessage("Enter dog\'s breed"),
        "dogBreedLabel": MessageLookupByLibrary.simpleMessage("Dog\'s Breed"),
        "dogDetails": MessageLookupByLibrary.simpleMessage("Dog Details"),
        "dogNameHint":
            MessageLookupByLibrary.simpleMessage("Enter dog\'s name"),
        "dogNameLabel": MessageLookupByLibrary.simpleMessage("Dog\'s Name"),
        "editDiaryTitle":
            MessageLookupByLibrary.simpleMessage("Edit Diary Title"),
        "entries": MessageLookupByLibrary.simpleMessage("Entries"),
        "entryDetails": MessageLookupByLibrary.simpleMessage("Entry Details"),
        "fillAllFields": MessageLookupByLibrary.simpleMessage(
            "Please fill all fields and upload an image."),
        "imageTitle": MessageLookupByLibrary.simpleMessage("Day\'s Image"),
        "missingFieldsError": MessageLookupByLibrary.simpleMessage(
            "Please fill all fields and upload an image."),
        "mood": MessageLookupByLibrary.simpleMessage("Mood"),
        "moodError":
            MessageLookupByLibrary.simpleMessage("Please select a mood."),
        "moodTitle": MessageLookupByLibrary.simpleMessage("Dog\'s Mood"),
        "mood_calm": MessageLookupByLibrary.simpleMessage("Calm"),
        "mood_excited": MessageLookupByLibrary.simpleMessage("Excited"),
        "mood_happy": MessageLookupByLibrary.simpleMessage("Happy"),
        "mood_sad": MessageLookupByLibrary.simpleMessage("Sad"),
        "navBlog": MessageLookupByLibrary.simpleMessage("Blog"),
        "navChats": MessageLookupByLibrary.simpleMessage("Chats"),
        "navDiaries": MessageLookupByLibrary.simpleMessage("Diaries"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
        "newEntryTitle":
            MessageLookupByLibrary.simpleMessage("Create New Entry"),
        "noDiaries":
            MessageLookupByLibrary.simpleMessage("No diaries available."),
        "noEntries":
            MessageLookupByLibrary.simpleMessage("No entries available."),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveButton": MessageLookupByLibrary.simpleMessage("Save"),
        "selectImage": MessageLookupByLibrary.simpleMessage("Select Image"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "unknownDog": MessageLookupByLibrary.simpleMessage("Unknown Dog")
      };
}
