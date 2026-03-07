import 'package:flutter_test/flutter_test.dart';
import 'package:banexy/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the initial loading and animations to settle.
    await tester.pumpAndSettle();

    // Verify that our HomeScreen is shown.
    expect(find.text('Words'), findsOneWidget);
  });
}
