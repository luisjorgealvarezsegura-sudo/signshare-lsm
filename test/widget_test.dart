import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signshare_lsm/main.dart';

void main() {
  testWidgets(
    'Home screen shows main actions',
    (WidgetTester tester) async {
      await tester.pumpWidget(const SignShareApp());

      expect(find.text('SignShare LSM'), findsOneWidget);

      expect(find.byKey(const Key('search_word_card')), findsOneWidget);

      expect(find.byKey(const Key('upload_sign_card')), findsOneWidget);

      expect(find.byKey(const Key('recognize_sign_card')), findsOneWidget);

      expect(find.byKey(const Key('about_project_card')), findsOneWidget);
    },
  );

  testWidgets(
    'Search card navigates',
    (WidgetTester tester) async {
      await tester.pumpWidget(const SignShareApp());

      await tester.tap(
        find.byKey(const Key('search_word_card')),
      );

      await tester.pumpAndSettle();

      expect(
        find.textContaining(
          'This screen will let users type a word',
        ),
        findsOneWidget,
      );
    },
  );
}