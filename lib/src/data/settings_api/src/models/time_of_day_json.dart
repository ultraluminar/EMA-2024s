import 'package:flutter/material.dart';

class TimeOfDayJson extends TimeOfDay {
  const TimeOfDayJson({
    required super.hour,
    super.minute = 0,
  });

  TimeOfDayJson.fromTimeOfDay(TimeOfDay timeOfDay)
      : this(hour: timeOfDay.hour, minute: timeOfDay.minute);

  factory TimeOfDayJson.fromJson(String time) {
    final parts = time.split(':');
    return TimeOfDayJson(
      hour: int.parse(parts.first),
      minute: int.parse(parts.last),
    );
  }

  TimeOfDay toTimeOfDay() => TimeOfDay(hour: hour, minute: minute);

  String toJson() {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }
}
