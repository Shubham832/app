//tests for widgets
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imbuedesk_project/screens/home.dart';

void main() {
  testWidgets('Add a todo and remove', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    final addField = find.byKey(ValueKey("addField"));
    final addButton = find.byKey(ValueKey("addButton"));
    final messageFinder = find.text('submit assignment');
    await tester.enterText(addField, 'submit assignment');
    await tester.tap(addButton);
    await tester.pump();
    expect(messageFinder, findsOneWidget);
  });
}
