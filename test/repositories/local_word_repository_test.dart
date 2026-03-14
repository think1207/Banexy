import 'package:flutter_test/flutter_test.dart';
import 'package:banexy/models/word.dart';
import 'package:banexy/repositories/local_word_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalWordRepository', () {
    late LocalWordRepository repository;
    final initialWords = [
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

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      repository = LocalWordRepository();
    });

    test(
      'loadWords returns initial words when no data is in SharedPreferences',
      () async {
        final words = await repository.loadWords();
        expect(
          words.map((e) => e.toJson()),
          equals(initialWords.map((e) => e.toJson())),
        );
      },
    );

    test('addWord adds a new word and saves it', () async {
      final newWord = WordCard(
        id: '9',
        text: 'test',
        meanings: ['テスト'],
        category: 'Test',
        partOfSpeech: 'Noun',
      );
      await repository.addWord(newWord);
      final words = await repository.loadWords();
      expect(words.length, initialWords.length + 1);
      expect(words.last.text, 'test');
    });

    test('saveWords saves a list of words', () async {
      final customWords = [
        WordCard(
          id: '10',
          text: 'custom',
          meanings: ['カスタム'],
          category: 'Test',
          partOfSpeech: 'Noun',
        ),
      ];
      await repository.saveWords(customWords);
      final words = await repository.loadWords();
      expect(words.length, 1);
      expect(words.first.text, 'custom');
    });

    test('resetData clears all words from SharedPreferences', () async {
      final customWords = [
        WordCard(
          id: '10',
          text: 'custom',
          meanings: ['カスタム'],
          category: 'Test',
          partOfSpeech: 'Noun',
        ),
      ];
      await repository.saveWords(customWords);
      var words = await repository.loadWords();
      expect(words.isNotEmpty, isTrue);

      await repository.resetData();
      words = await repository.loadWords();
      // reset後はmasterDataが返される
      expect(
        words.map((e) => e.toJson()),
        equals(initialWords.map((e) => e.toJson())),
      );
    });
  });
}
