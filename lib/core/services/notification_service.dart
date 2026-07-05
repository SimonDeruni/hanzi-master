import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service.g.dart';

@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService();
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('launcher_icon');
    
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        // Handle notification tap
      },
    );
    
    _isInitialized = true;
  }

  Future<bool> requestPermissions() async {
    bool? granted = false;
    
    // Android 13+
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      granted = await androidImplementation.requestNotificationsPermission();
    }
    
    // iOS
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosImplementation != null) {
      granted = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    
    return granted ?? false;
  }

  Future<void> scheduleDailyDrop(int hour, int minute) async {
    await _flutterLocalNotificationsPlugin.cancel(id: 1); // ID 1 = Daily Drop
    
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'daily_drop_channel',
      'Daily Drop',
      channelDescription: 'Daily notifications for Word of the Day and news',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launcher_icon',
      color: const Color(0xFFFDFCF0), // Warm Xuan Paper
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: 1,
      title: 'The Daily Spark is here! ✨',
      body: 'A new Word, Article, and Video of the Day are waiting for you!',
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleSpacedRepetition(int hour, int minute, int dueCount) async {
    await _flutterLocalNotificationsPlugin.cancel(id: 2); // ID 2 = SR
    if (dueCount <= 0) return;

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'spaced_repetition_channel',
      'Spaced Repetition',
      channelDescription: 'Reminders for flashcards due for review',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launcher_icon',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: 2,
      title: 'Time to Review! 📚',
      body: 'You have $dueCount flashcards waiting for review! Keep your memory sharp.',
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleMissYou() async {
    await _flutterLocalNotificationsPlugin.cancel(id: 3); // ID 3 = Miss You

    final tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(days: 3));

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'miss_you_channel',
      'Engagement Reminders',
      channelDescription: 'Reminders when you haven\'t used the app for a few days',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: 'launcher_icon',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: 3,
      title: 'Never miss a stroke! 🖌️',
      body: 'It\'s been a few days! Take 5 minutes to learn a new Hanzi today.',
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleTrialEndingReminder(DateTime trialExpirationDate) async {
    await _flutterLocalNotificationsPlugin.cancel(id: 4); // ID 4 = Trial Reminder
    
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // Schedule 24 hours before expiration
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(trialExpirationDate.subtract(const Duration(hours: 24)), tz.local);
    
    // Only schedule if it's in the future
    if (scheduledDate.isBefore(now)) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'trial_reminder_channel',
      'Trial Reminders',
      channelDescription: 'Notifications for your trial status',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launcher_icon',
      color: const Color(0xFFC4863A), // Gold accent
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: 4,
      title: 'Your trial ends tomorrow! ⏳',
      body: 'Come review your Hanzi and try a Live Call before your free access ends!',
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
