// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `DogDiary`
  String get appTitle {
    return Intl.message(
      'DogDiary',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `No diaries available.`
  String get noDiaries {
    return Intl.message(
      'No diaries available.',
      name: 'noDiaries',
      desc: '',
      args: [],
    );
  }

  /// `Delete Diary`
  String get deleteDiary {
    return Intl.message(
      'Delete Diary',
      name: 'deleteDiary',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this diary?`
  String get deleteDiaryConfirmation {
    return Intl.message(
      'Do you really want to delete this diary?',
      name: 'deleteDiaryConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Bound to`
  String get boundTo {
    return Intl.message(
      'Bound to',
      name: 'boundTo',
      desc: '',
      args: [],
    );
  }

  /// `Created on`
  String get createdOn {
    return Intl.message(
      'Created on',
      name: 'createdOn',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Dog`
  String get unknownDog {
    return Intl.message(
      'Unknown Dog',
      name: 'unknownDog',
      desc: '',
      args: [],
    );
  }

  /// `Create New Diary`
  String get createDiaryTitle {
    return Intl.message(
      'Create New Diary',
      name: 'createDiaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Diary Title`
  String get diaryTitle {
    return Intl.message(
      'Diary Title',
      name: 'diaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get diaryTitleLabel {
    return Intl.message(
      'Title',
      name: 'diaryTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the diary title`
  String get diaryTitleHint {
    return Intl.message(
      'Enter the diary title',
      name: 'diaryTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Dog Details`
  String get dogDetails {
    return Intl.message(
      'Dog Details',
      name: 'dogDetails',
      desc: '',
      args: [],
    );
  }

  /// `Dog's Name`
  String get dogNameLabel {
    return Intl.message(
      'Dog\'s Name',
      name: 'dogNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter dog's name`
  String get dogNameHint {
    return Intl.message(
      'Enter dog\'s name',
      name: 'dogNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Dog's Breed`
  String get dogBreedLabel {
    return Intl.message(
      'Dog\'s Breed',
      name: 'dogBreedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter dog's breed`
  String get dogBreedHint {
    return Intl.message(
      'Enter dog\'s breed',
      name: 'dogBreedHint',
      desc: '',
      args: [],
    );
  }

  /// `Dog's Birth Date`
  String get dogBirthDateLabel {
    return Intl.message(
      'Dog\'s Birth Date',
      name: 'dogBirthDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter birth date (dd.MM.yyyy)`
  String get dogBirthDateHint {
    return Intl.message(
      'Enter birth date (dd.MM.yyyy)',
      name: 'dogBirthDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Diary Cover`
  String get diaryCover {
    return Intl.message(
      'Diary Cover',
      name: 'diaryCover',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image`
  String get chooseImage {
    return Intl.message(
      'Choose Image',
      name: 'chooseImage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message(
      'Save',
      name: 'saveButton',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields and upload an image.`
  String get missingFieldsError {
    return Intl.message(
      'Please fill all fields and upload an image.',
      name: 'missingFieldsError',
      desc: '',
      args: [],
    );
  }

  /// `Birth date cannot be empty.`
  String get birthDateEmptyError {
    return Intl.message(
      'Birth date cannot be empty.',
      name: 'birthDateEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Date cannot be in the future.`
  String get birthDateFutureError {
    return Intl.message(
      'Date cannot be in the future.',
      name: 'birthDateFutureError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format. Use dd.MM.yyyy.`
  String get birthDateFormatError {
    return Intl.message(
      'Invalid format. Use dd.MM.yyyy.',
      name: 'birthDateFormatError',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get createdAt {
    return Intl.message(
      'Created at',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Entries`
  String get entries {
    return Intl.message(
      'Entries',
      name: 'entries',
      desc: '',
      args: [],
    );
  }

  /// `No entries available.`
  String get noEntries {
    return Intl.message(
      'No entries available.',
      name: 'noEntries',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get mood {
    return Intl.message(
      'Mood',
      name: 'mood',
      desc: '',
      args: [],
    );
  }

  /// `Add New Entry`
  String get addNewEntry {
    return Intl.message(
      'Add New Entry',
      name: 'addNewEntry',
      desc: '',
      args: [],
    );
  }

  /// `Edit Diary Title`
  String get editDiaryTitle {
    return Intl.message(
      'Edit Diary Title',
      name: 'editDiaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get changeImage {
    return Intl.message(
      'Change Image',
      name: 'changeImage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Entry Details`
  String get entryDetails {
    return Intl.message(
      'Entry Details',
      name: 'entryDetails',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Create New Entry`
  String get newEntryTitle {
    return Intl.message(
      'Create New Entry',
      name: 'newEntryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Day Description`
  String get descriptionTitle {
    return Intl.message(
      'Day Description',
      name: 'descriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Describe the day`
  String get descriptionHint {
    return Intl.message(
      'Describe the day',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Description cannot be empty.`
  String get descriptionError {
    return Intl.message(
      'Description cannot be empty.',
      name: 'descriptionError',
      desc: '',
      args: [],
    );
  }

  /// `Dog's Mood`
  String get moodTitle {
    return Intl.message(
      'Dog\'s Mood',
      name: 'moodTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please select a mood.`
  String get moodError {
    return Intl.message(
      'Please select a mood.',
      name: 'moodError',
      desc: '',
      args: [],
    );
  }

  /// `Day's Image`
  String get imageTitle {
    return Intl.message(
      'Day\'s Image',
      name: 'imageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Image`
  String get selectImage {
    return Intl.message(
      'Select Image',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields and upload an image.`
  String get fillAllFields {
    return Intl.message(
      'Please fill all fields and upload an image.',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Happy`
  String get mood_happy {
    return Intl.message(
      'Happy',
      name: 'mood_happy',
      desc: '',
      args: [],
    );
  }

  /// `Sad`
  String get mood_sad {
    return Intl.message(
      'Sad',
      name: 'mood_sad',
      desc: '',
      args: [],
    );
  }

  /// `Excited`
  String get mood_excited {
    return Intl.message(
      'Excited',
      name: 'mood_excited',
      desc: '',
      args: [],
    );
  }

  /// `Calm`
  String get mood_calm {
    return Intl.message(
      'Calm',
      name: 'mood_calm',
      desc: '',
      args: [],
    );
  }

  /// `{title} page is coming soon!`
  String comingSoon(Object title) {
    return Intl.message(
      '$title page is coming soon!',
      name: 'comingSoon',
      desc: '',
      args: [title],
    );
  }

  /// `Diaries`
  String get navDiaries {
    return Intl.message(
      'Diaries',
      name: 'navDiaries',
      desc: '',
      args: [],
    );
  }

  /// `Blog`
  String get navBlog {
    return Intl.message(
      'Blog',
      name: 'navBlog',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get navChats {
    return Intl.message(
      'Chats',
      name: 'navChats',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get navProfile {
    return Intl.message(
      'Profile',
      name: 'navProfile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Copyright`
  String get copyright {
    return Intl.message(
      'Copyright',
      name: 'copyright',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
