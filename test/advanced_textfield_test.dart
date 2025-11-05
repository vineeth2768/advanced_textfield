import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:textfield_customizer/advanced_textfield.dart';

void main() {
  testWidgets('AdvancedTextField renders correctly',
      (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextfieldCustomizer(
            hintText: 'Enter text',
            controller: controller,
          ),
        ),
      ),
    );

    // ✅ Assertions
    expect(find.byType(TextfieldCustomizer), findsOneWidget);
    expect(find.text('Enter text'), findsOneWidget);
  });
}
