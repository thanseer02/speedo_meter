import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speedtrack/main.dart';

void main() {
  testWidgets('App loads and renders placeholder text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SpeedTrackApp());

    // Wait for the ScreenUtilInit to settle
    await tester.pumpAndSettle();

    // Verify that our placeholder text is displayed.
    expect(find.text('SpeedTrack Restructured Successfully'), findsOneWidget);
    
    // Verify that the Dark Mode switch exists.
    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
  });
}
