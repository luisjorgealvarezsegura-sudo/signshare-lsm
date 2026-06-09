import 'package:flutter_test/flutter_test.dart';
import 'package:signshare_lsm/main.dart';

void main() {
  testWidgets('Home screen shows main actions', (tester) async {
    await tester.pumpWidget(const SignShareApp());

    expect(find.text('SignShare LSM'), findsOneWidget);

    expect(find.textContaining('Search'), findsWidgets);
    expect(find.textContaining('Upload'), findsWidgets);
    expect(find.textContaining('About'), findsWidgets);
  });

  testWidgets('Search card navigates', (tester) async {
    await tester.pumpWidget(const SignShareApp());

    await tester.tap(find.byKey(const Key('search_word_card')));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('This screen will let users type a word'),
      findsOneWidget,
    );
  });
}