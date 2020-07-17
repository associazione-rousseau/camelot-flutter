// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:rousseau_vote/main.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';

void main() {

 testWidgets('Is the app findable by type', (WidgetTester tester) async {
    configure();
    await tester.pumpWidget(RousseauVoteApp());
    expect(find.byType(RousseauVoteApp), findsWidgets);
 });
}
