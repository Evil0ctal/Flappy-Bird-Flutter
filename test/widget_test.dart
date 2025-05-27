// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flappy_bird_flutter/main.dart';
import 'package:flappy_bird_flutter/services/storage_service.dart';

void main() {
  testWidgets('Flappy Bird app loads', (WidgetTester tester) async {
    // Create a test storage service
    final storageService = StorageService();
    await storageService.init();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<StorageService>.value(value: storageService),
        ],
        child: const FlappyBirdApp(),
      ),
    );

    // Verify that the app shows the title
    expect(find.text('Flappy Bird'), findsOneWidget);
  });
}
