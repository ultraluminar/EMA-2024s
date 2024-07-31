import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class NotificationsApi {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _notificationDetails = NotificationDetails(
    iOS: DarwinNotificationDetails(threadIdentifier: "channel0"),
    android: AndroidNotificationDetails(
      "channel0",
      "channel0",
      channelDescription: "channel0 for expiration related notifications",
      category: AndroidNotificationCategory.reminder,
      groupKey: "com.fridge_manager.app.EXPIRATION",
    ),
  );

  static const _dateInterpretation =
      UILocalNotificationDateInterpretation.wallClockTime;

  static Future<void> init() async {
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    initializeTimeZones();
    final locationName = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(locationName));

    HiveSettingsApi.listenable(
      settings: [Settings.dailyNotificationTime.name],
    ).addListener(() async {
      log("listener called");
      onNotificationTimeChange();
    });

    onNotificationTimeChange();
  }

  static Future<void> onNotificationTimeChange() async {
    await NotificationsApi.cancelAll();
    NotificationsApi.scheduleAll(
      HiveProductsApi.listenable().value.values,
    );
  }

  static void _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
  }) {
    _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      _notificationDetails,
      uiLocalNotificationDateInterpretation: _dateInterpretation,
    );
  }

  static void show(int id, String title, String body) {
    _plugin.show(id, title, body, _notificationDetails);
  }

  static void schedule(Product product) {
    final id = product.uuid.hashCode;
    const body = 'click to open the app.';
    final expiresString = product.isExpired
        ? S().productListTileDescriptionExpired(product.expiresInDays.abs())
        : S().productListTileDescriptionNotExpired(product.expiresInDays);

    final title = '${product.name} $expiresString!';
    final date = product.expiresAt.addDays(-2);

    final TimeOfDay time = HiveSettingsApi.listenable()
        .value
        .get(Settings.dailyNotificationTime.name);

    final scheduledDate = TZDateTime.local(
        date.year, date.month, date.day, time.hour, time.minute);

    if (product.expiresInDays <= 1 ||
        scheduledDate.isBefore(TZDateTime.now(local))) {
      show(id, title, body);
    } else {
      _scheduleNotification(
          id: id, title: title, body: body, scheduledDate: scheduledDate);
    }
  }

  static void scheduleAll(Iterable<Product> products) {
    for (final product in products) {
      schedule(product);
    }
  }

  static Future<void> update(Product product) async {
    await cancel(product);
    schedule(product);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  static Future<void> cancel(Product product) async {
    await _plugin.cancel(product.uuid.hashCode);
  }
}
