import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:speedtrack/main.dart';
import 'package:speedtrack/features/main_navigation/view/main_navigation_screen.dart';
import 'package:speedtrack/features/dashboard/view/dashboard_screen.dart';
import 'package:speedtrack/providers/theme_provider.dart';

void main() {
  testWidgets('App loads and navigates to MainNavigationScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const SpeedTrackApp(),
      ),
    );

    // Wait for the ScreenUtilInit to settle
    await tester.pumpAndSettle();

    // Verify that the MainNavigationScreen is displayed.
    expect(find.byType(MainNavigationScreen), findsOneWidget);
    
    // Verify Dashboard Screen is visible initially
    expect(find.byType(DashboardScreen), findsOneWidget);
  });
}
