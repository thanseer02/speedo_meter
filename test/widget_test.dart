import 'package:flutter_test/flutter_test.dart';
import 'package:speedtrack/main.dart';
import 'package:speedtrack/features/main_navigation/view/main_navigation_screen.dart';

void main() {
  testWidgets('App loads and navigates to MainNavigationScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SpeedTrackApp());

    // Wait for the ScreenUtilInit to settle
    await tester.pumpAndSettle();

    // Verify that the MainNavigationScreen is displayed.
    expect(find.byType(MainNavigationScreen), findsOneWidget);
    
    // Verify Dashboard Screen text is visible initially
    expect(find.text('Dashboard Screen'), findsOneWidget);
  });
}
