import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_service.g.dart';

@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService();
}

class NotificationService {
  static const int practiceReminderId = 1;
  static const int _legacyReviewReminderId = 2;
  static const int _legacyMissYouReminderId = 3;
  static const String _enabledKey = 'practice_reminder_enabled';
  static const String _hourKey = 'practice_reminder_hour';
  static const String _minuteKey = 'practice_reminder_minute';

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    try {
      // Set a default fallback location so tz.local doesn't throw an exception
      tz.setLocalLocation(tz.getLocation('UTC'));
    } catch (e) {
      debugPrint('Could not set local timezone: $e');
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        // Handle notification tap
      },
    );

    _isInitialized = true;
  }

  Future<bool> requestPermissions() async {
    bool? granted = false;

    // Android 13+
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      granted = await androidImplementation.requestNotificationsPermission();
    }

    // iOS
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosImplementation != null) {
      granted = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    return granted ?? false;
  }

  Future<bool> isPracticeReminderEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_enabledKey) ?? false;
  }

  Future<({int hour, int minute})> practiceReminderTime() async {
    final preferences = await SharedPreferences.getInstance();
    return (
      hour: preferences.getInt(_hourKey) ?? 9,
      minute: preferences.getInt(_minuteKey) ?? 0,
    );
  }

  /// Schedules the app's single learning reminder. Legacy review and
  /// re-engagement notifications are cancelled so users receive at most one
  /// learning nudge per day. Trial reminders use a separate transactional ID.
  Future<void> setPracticeReminder({
    required bool enabled,
    required int hour,
    required int minute,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_enabledKey, enabled);
    await preferences.setInt(_hourKey, hour);
    await preferences.setInt(_minuteKey, minute);
    await init();
    await cancel(_legacyReviewReminderId);
    await cancel(_legacyMissYouReminderId);
    await cancel(practiceReminderId);
    if (enabled) {
      await _schedulePracticeReminder(hour, minute);
    }
  }

  /// A completed practice session makes today's reminder unnecessary. The
  /// recurring reminder is moved to tomorrow rather than disabled permanently.
  Future<void> recordPracticeCompleted() async {
    if (!await isPracticeReminderEnabled()) return;
    final time = await practiceReminderTime();
    await init();
    await cancel(practiceReminderId);
    await _schedulePracticeReminder(time.hour, time.minute, skipToday: true);
  }

  Future<void> _schedulePracticeReminder(
    int hour,
    int minute, {
    bool skipToday = false,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (skipToday || !scheduledDate.isAfter(now)) {
      scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day + 1,
        hour,
        minute,
      );
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'practice_reminder_channel',
        'Practice reminders',
        channelDescription: 'One optional daily reminder to practice Chinese',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'launcher_icon',
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: practiceReminderId,
      title: 'A few minutes of Chinese? 🌱',
      body: 'Keep your progress moving with a short practice session.',
      scheduledDate: scheduledDate,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancel(int id) async {
    await init();
    await _flutterLocalNotificationsPlugin.cancel(id: id);
  }

  // Compatibility wrapper for the existing onboarding flow.
  Future<void> scheduleDailyDrop(int hour, int minute) async {
    await setPracticeReminder(enabled: true, hour: hour, minute: minute);
  }

  Future<void> scheduleSpacedRepetition(
      int hour, int minute, int dueCount) async {
    await _flutterLocalNotificationsPlugin.cancel(id: 2); // ID 2 = SR
    if (dueCount <= 0) return;

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
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
      body:
          'You have $dueCount flashcards waiting for review! Keep your memory sharp.',
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleMissYou() async {
    await _flutterLocalNotificationsPlugin.cancel(id: 3); // ID 3 = Miss You

    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(tz.local).add(const Duration(days: 3));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'miss_you_channel',
      'Engagement Reminders',
      channelDescription:
          'Reminders when you haven\'t used the app for a few days',
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
    await _flutterLocalNotificationsPlugin.cancel(
        id: 4); // ID 4 = Trial Reminder

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // Schedule 24 hours before expiration
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(
        trialExpirationDate.subtract(const Duration(hours: 24)), tz.local);

    // Only schedule if it's in the future
    if (scheduledDate.isBefore(now)) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'trial_reminder_channel',
      'Trial Reminders',
      channelDescription: 'Notifications for your trial status',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launcher_icon',
      color: Color(0xFFC4863A), // Gold accent
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: 4,
      title: 'Your trial ends tomorrow! ⏳',
      body:
          'Come review your Hanzi and try a Live Call before your free access ends!',
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
