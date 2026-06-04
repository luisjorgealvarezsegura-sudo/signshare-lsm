import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signshare_lsm/main.dart';

void main() {
  testWidgets('Home screen shows title and main actions', (tester) async {
    await tester.pumpWidget(const SignShareApp());

    expect(find.text('SignShare LSM'), findsOneWidget);
    expect(find.text('Community Sign Library'), findsOneWidget);
    expect(find.text('Search a Word'), findsOneWidget);
    expect(find.text('Upload a Sign'), findsOneWidget);
    expect(find.text('Recognize a Sign'), findsOneWidget);
    expect(find.text('About the Project'), findsOneWidget);
  });

  testWidgets('Search card opens search screen', (tester) async {
    await tester.pumpWidget(const SignShareApp());

    await tester.tap(find.byKey(const Key('search_word_card')));
    await tester.pumpAndSettle();

    expect(find.text('Search a Word'), findsOneWidget);
    expect(
      find.textContaining('This screen will let users type a word'),
      findsOneWidget,
    );
  });
}
