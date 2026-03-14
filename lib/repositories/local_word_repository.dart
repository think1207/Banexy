import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/word.dart';
import './base_word_repository.dart';

class LocalWordRepository implements BaseWordRepository {
  static final LocalWordRepository _instance = LocalWordRepository._internal();

  factory LocalWordRepository() => _instance;

  LocalWordRepository._internal();

  static const String _storageKey = 'user_study_data';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  final List<WordCard> _masterData = [
    WordCard(
      id: '1',
      text: 'Agile',
      meanings: ['俊敏な', 'アジャイル開発'],
      category: 'Technology',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '2',
      text: 'Consensus',
      meanings: ['合意', '総意'],
      category: 'Business',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '3',
      text: 'Legacy',
      meanings: ['遺産', '古いシステム'],
      category: 'Technology',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '4',
      text: 'Stakeholder',
      meanings: ['利害関係者'],
      category: 'Business',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '5',
      text: 'Scalability',
      meanings: ['拡張性'],
      category: 'Technology',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '6',
      text: 'Pivot',
      meanings: ['方向転換'],
      category: 'Business',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '7',
      text: 'Disruptive',
      meanings: ['破壊的な'],
      category: 'Business',
      partOfSpeech: 'Noun',
    ),
    WordCard(
      id: '8',
      text: 'Retention',
      meanings: ['維持', '保持率'],
      category: 'Business',
      partOfSpeech: 'Noun',
    ),
  ];

  @override
  Future<List<WordCard>> loadWords() async {
    final prefs = await _prefs;
    String? jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      return List<WordCard>.from(_masterData);
    }

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded
          .map((e) => WordCard.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error loading data: $e");
      return List<WordCard>.from(_masterData);
    }
  }

  @override
  Future<void> addWord(WordCard newWord) async {
    final currentList = await loadWords();
    currentList.add(newWord);
    await saveWords(currentList);
  }

  @override
  Future<void> saveWords(List<WordCard> words) async {
    final prefs = await _prefs;
    String jsonString = jsonEncode(words.map((w) => w.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  @override
  Future<void> resetData() async {
    final prefs = await _prefs;
    await prefs.remove(_storageKey);
  }
}
