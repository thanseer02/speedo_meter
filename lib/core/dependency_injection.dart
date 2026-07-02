import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedtrack/core/logger/log_helper.dart';

// Services
import 'package:speedtrack/services/permissions/permission_service.dart';
import 'package:speedtrack/services/storage/storage_service.dart';
import 'package:speedtrack/services/notifications/notification_service.dart';
import 'package:speedtrack/services/gps/location_service.dart';
import 'package:speedtrack/services/background/background_tracking_service.dart';

// Repositories
import 'package:speedtrack/repositories/interfaces/tracking_repository.dart';
import 'package:speedtrack/repositories/interfaces/history_repository.dart';
import 'package:speedtrack/repositories/interfaces/settings_repository.dart';
import 'package:speedtrack/repositories/implementations/tracking_repository_impl.dart';
import 'package:speedtrack/repositories/implementations/history_repository_impl.dart';
import 'package:speedtrack/repositories/implementations/settings_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  LogHelper.i('Initializing Dependency Injection...');

  // 1. Core / Async Dependencies
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // 2. Services
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());

  final storageService = StorageService();
  await storageService.init(); // Initialize Hive
  getIt.registerLazySingleton<StorageService>(() => storageService);

  final notificationService = NotificationService();
  await notificationService.init(); // Initialize Local Notifications
  getIt.registerLazySingleton<NotificationService>(() => notificationService);

  getIt.registerLazySingleton<LocationService>(() => LocationService());

  final backgroundService = BackgroundTrackingService();
  await backgroundService.initialize(); // Initialize Flutter Background Service
  getIt.registerLazySingleton<BackgroundTrackingService>(
    () => backgroundService,
  );

  // 3. Repositories
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(prefs: getIt()),
  );

  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(storageService: getIt()),
  );

  getIt.registerLazySingleton<TrackingRepository>(
    () => TrackingRepositoryImpl(
      locationService: getIt(),
      backgroundService: getIt(),
      notificationService: getIt(),
      storageService: getIt(),
    ),
  );

  LogHelper.i('Dependency Injection Setup Complete.');
}
