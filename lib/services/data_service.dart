import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Für JSON-Konvertierung
import '../models/diary_entry.dart';
import '../models/dog.dart';
import '../models/diary.dart';

/// Handles data-related operations and integrates persistent storage.
class DataService with ChangeNotifier {
  final List<Dog> _dogs = [];
  final List<Diary> _diaries = [];
  final List<DiaryEntry> _entries = [];

  List<Dog> get dogs => [..._dogs];
  List<Diary> get diaries => [..._diaries];

  List<Diary> getDiaries(String dogId) {
    return _diaries.where((diary) => diary.dogId == dogId).toList();
  }

  /// Adds a new dog and persists the data.
  void addDog(Dog dog) async {
    _dogs.add(dog);
    await _saveData();
    notifyListeners();
  }

  /// Adds a new diary and persists the data.
  void addDiary(Diary diary) async {
    _diaries.add(diary);
    await _saveData();
    notifyListeners();
  }

  Future<void> updateDiary(Diary updatedDiary) async {
    final index = _diaries.indexWhere((diary) => diary.id == updatedDiary.id);
    if (index != -1) {
      _diaries[index] = updatedDiary;
      await _saveData();
      notifyListeners();
    }
  }

  /// Deletes a dog and all associated diaries, then persists the data.
  void deleteDog(String dogId) async {
    _dogs.removeWhere((dog) => dog.id == dogId);
    _diaries.removeWhere((diary) => diary.dogId == dogId);
    await _saveData();
    notifyListeners();
  }

  /// Deletes a specific diary and persists the data.
  void deleteDiary(String diaryId) async {
    _diaries.removeWhere((diary) => diary.id == diaryId);
    await _saveData();
    notifyListeners();
  }

  /// Saves dogs and diaries to local storage.
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final dogsJson = jsonEncode(_dogs.map((dog) => dog.toJson()).toList());
    final diariesJson = jsonEncode(_diaries.map((diary) => diary.toJson()).toList());
    await prefs.setString('dogs', dogsJson);
    await prefs.setString('diaries', diariesJson);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load dogs
    final dogsJson = prefs.getString('dogs');
    if (dogsJson != null) {
      final List<dynamic> dogsList = jsonDecode(dogsJson);
      _dogs.clear();
      _dogs.addAll(dogsList.map((json) => Dog.fromJson(json)).toList());
    }

    // Load diaries
    final diariesJson = prefs.getString('diaries');
    if (diariesJson != null) {
      final List<dynamic> diariesList = jsonDecode(diariesJson);
      _diaries.clear();
      _diaries.addAll(diariesList.map((json) => Diary.fromJson(json)).toList());
    }

    // Load entries
    final entriesJson = prefs.getString('entries');
    if (entriesJson != null) {
      final List<dynamic> entriesList = jsonDecode(entriesJson);
      _entries.clear();
      _entries.addAll(entriesList.map((json) => DiaryEntry.fromJson(json)).toList());
    }

    // Notify listeners after loading all data
    notifyListeners();
  }


  List<DiaryEntry> getEntries(String diaryId) {
    return _entries.where((entry) => entry.diaryId == diaryId).toList();
  }

  void addEntry(DiaryEntry entry) async {
    _entries.add(entry);
    await _saveEntries();
    notifyListeners();
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = jsonEncode(_entries.map((entry) => entry.toJson()).toList());
    await prefs.setString('entries', entriesJson);
  }

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getString('entries');

    if (entriesJson != null) {
      final List<dynamic> entriesList = jsonDecode(entriesJson);
      _entries.clear();
      _entries.addAll(entriesList.map((json) => DiaryEntry.fromJson(json)).toList());
    }

    notifyListeners();
  }


}
