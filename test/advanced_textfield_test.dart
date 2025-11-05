import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_textfield/advanced_textfield.dart';

void main() {
  testWidgets('AdvancedTextField renders correctly',
      (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdvancedTextField(
            hintText: 'Enter text',
            controller: controller,
          ),
        ),
      ),
    );

    // ✅ Assertions
    expect(find.byType(AdvancedTextField), findsOneWidget);
    expect(find.text('Enter text'), findsOneWidget);
  });
}
