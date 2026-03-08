import 'package:flutter/material.dart';
import '../models/word.dart';

class SortCompleteScreen extends StatelessWidget {
  final List<WordCard> retryList;

  const SortCompleteScreen({
    super.key,
    required this.retryList,
  });

  static const Color _primaryColor = Color(0xFF8BA094);
  static const Color _bgColor = Color(0xFFF4F5F6);
  static const Color _textColorDark = Color(0xFF2C3E50);

  @override
  Widget build(BuildContext context) {
    final retryCount = retryList.length;

    final displayWords = retryList.take(5).toList();
    final remainingCount = retryCount - displayWords.length;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: _textColorDark),
          // ×ボタンでホームに戻る
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: const [
            Text(
              'Sort Complete',
              style: TextStyle(
                color: _textColorDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '仕分け完了',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: _primaryColor,
                  ),
                  child: const Icon(Icons.check, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 32),

                const Text(
                  '準備完了',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _textColorDark,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  '$retryCount個の新しい単語を選びました。\nこれからひとつずつ学習していきましょう。',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '今日学ぶ単語',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            ...displayWords.map((w) => _buildWordChip(w.text)),
                            if (remainingCount > 0)
                              _buildWordChip('+$remainingCount'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: ここに実際の学習セッション画面への遷移を追加する
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('学習画面へ遷移します（今後実装）')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Start Learning',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _textColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Later',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWordChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _textColorDark,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}