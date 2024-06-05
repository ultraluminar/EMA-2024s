extension DateTimeX on DateTime {
  DateTime get date => this.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
}
