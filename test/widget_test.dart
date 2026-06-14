import 'package:flutter_test/flutter_test.dart';
import 'package:signshare_lsm/main.dart';

void main() {
  testWidgets('App starts successfully', (tester) async {
    await tester.pumpWidget(const SignShareApp());

    expect(find.text('SignShare LSM'), findsOneWidget);
  });

  testWidgets('Search card exists', (tester) async {
    await tester.pumpWidget(const SignShareApp());

    expect(find.textContaining('Search'), findsWidgets);
  });
}