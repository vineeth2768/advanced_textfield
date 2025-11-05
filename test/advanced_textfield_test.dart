import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_textfield/advanced_textfield.dart';

void main() {
  testWidgets('CustomTextField renders correctly', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(hintText: 'Enter text', controller: controller),
        ),
      ),
    );

    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.text('Enter text'), findsOneWidget);
  });
}
