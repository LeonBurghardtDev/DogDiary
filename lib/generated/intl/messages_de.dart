// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(title) => "${title} Seite kommt bald!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewEntry":
            MessageLookupByLibrary.simpleMessage("Neuen Eintrag hinzufügen"),
        "appTitle": MessageLookupByLibrary.simpleMessage("DogDiary"),
        "birthDateEmptyError": MessageLookupByLibrary.simpleMessage(
            "Das Geburtsdatum darf nicht leer sein."),
        "birthDateFormatError": MessageLookupByLibrary.simpleMessage(
            "Ungültiges Format. Verwende dd.MM.yyyy."),
        "birthDateFutureError": MessageLookupByLibrary.simpleMessage(
            "Das Datum darf nicht in der Zukunft liegen."),
        "boundTo": MessageLookupByLibrary.simpleMessage("Gebunden an"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "changeImage": MessageLookupByLibrary.simpleMessage("Bild ändern"),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Sprache ändern"),
        "chooseImage": MessageLookupByLibrary.simpleMessage("Bild auswählen"),
        "close": MessageLookupByLibrary.simpleMessage("Schließen"),
        "comingSoon": m0,
        "copyright": MessageLookupByLibrary.simpleMessage("Copyright"),
        "createDiaryTitle":
            MessageLookupByLibrary.simpleMessage("Neues Tagebuch erstellen"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Erstellt am"),
        "createdOn": MessageLookupByLibrary.simpleMessage("Erstellt am"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deleteDiary": MessageLookupByLibrary.simpleMessage("Tagebuch löschen"),
        "deleteDiaryConfirmation": MessageLookupByLibrary.simpleMessage(
            "Möchten Sie dieses Tagebuch wirklich löschen?"),
        "description": MessageLookupByLibrary.simpleMessage("Beschreibung"),
        "descriptionError": MessageLookupByLibrary.simpleMessage(
            "Die Beschreibung darf nicht leer sein."),
        "descriptionHint":
            MessageLookupByLibrary.simpleMessage("Erzähle von dem Tag"),
        "descriptionTitle":
            MessageLookupByLibrary.simpleMessage("Beschreibung des Tages"),
        "diaryCover":
            MessageLookupByLibrary.simpleMessage("Titelbild des Tagebuchs"),
        "diaryTitle": MessageLookupByLibrary.simpleMessage("Tagebuch Titel"),
        "diaryTitleHint": MessageLookupByLibrary.simpleMessage(
            "Gib den Titel des Tagebuchs ein"),
        "diaryTitleLabel": MessageLookupByLibrary.simpleMessage("Titel"),
        "dogBirthDateHint": MessageLookupByLibrary.simpleMessage(
            "Gib das Geburtsdatum ein (dd.MM.yyyy)"),
        "dogBirthDateLabel":
            MessageLookupByLibrary.simpleMessage("Geburtsdatum des Hundes"),
        "dogBreedHint": MessageLookupByLibrary.simpleMessage(
            "Gib die Rasse des Hundes ein"),
        "dogBreedLabel":
            MessageLookupByLibrary.simpleMessage("Rasse des Hundes"),
        "dogDetails": MessageLookupByLibrary.simpleMessage("Hundedaten"),
        "dogNameHint": MessageLookupByLibrary.simpleMessage(
            "Gib den Namen des Hundes ein"),
        "dogNameLabel": MessageLookupByLibrary.simpleMessage("Name des Hundes"),
        "editDiaryTitle":
            MessageLookupByLibrary.simpleMessage("Tagebuch bearbeiten"),
        "entries": MessageLookupByLibrary.simpleMessage("Einträge"),
        "entryDetails": MessageLookupByLibrary.simpleMessage("Eintragsdetails"),
        "fillAllFields": MessageLookupByLibrary.simpleMessage(
            "Bitte alle Felder ausfüllen und ein Bild hochladen."),
        "imageTitle": MessageLookupByLibrary.simpleMessage("Bild des Tages"),
        "missingFieldsError": MessageLookupByLibrary.simpleMessage(
            "Bitte alle Felder ausfüllen und ein Bild hochladen."),
        "mood": MessageLookupByLibrary.simpleMessage("Stimmung"),
        "moodError": MessageLookupByLibrary.simpleMessage(
            "Bitte eine Stimmung auswählen."),
        "moodTitle":
            MessageLookupByLibrary.simpleMessage("Stimmung des Hundes"),
        "mood_calm": MessageLookupByLibrary.simpleMessage("Ruhig"),
        "mood_excited": MessageLookupByLibrary.simpleMessage("Aufgeregt"),
        "mood_happy": MessageLookupByLibrary.simpleMessage("Glücklich"),
        "mood_sad": MessageLookupByLibrary.simpleMessage("Traurig"),
        "navBlog": MessageLookupByLibrary.simpleMessage("Blog"),
        "navChats": MessageLookupByLibrary.simpleMessage("Chats"),
        "navDiaries": MessageLookupByLibrary.simpleMessage("Tagebücher"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
        "newEntryTitle":
            MessageLookupByLibrary.simpleMessage("Neuen Eintrag erstellen"),
        "noDiaries": MessageLookupByLibrary.simpleMessage(
            "Noch keine Tagebücher vorhanden."),
        "noEntries":
            MessageLookupByLibrary.simpleMessage("Keine Einträge vorhanden."),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "saveButton": MessageLookupByLibrary.simpleMessage("Speichern"),
        "selectImage": MessageLookupByLibrary.simpleMessage("Bild auswählen"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "title": MessageLookupByLibrary.simpleMessage("Titel"),
        "unknownDog": MessageLookupByLibrary.simpleMessage("Unbekannter Hund")
      };
}
