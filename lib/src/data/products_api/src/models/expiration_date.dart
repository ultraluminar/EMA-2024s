import 'package:intl/intl.dart';

class ExpirationDate extends DateTime {
  static final dateFormat = DateFormat('dd.MM.yyyy');

  ExpirationDate(super.year, super.month, super.day);

  ExpirationDate.fromDate(DateTime date)
      : this(date.year, date.month, date.day);

  ExpirationDate.today() : this.fromDate(DateTime.now());

  ExpirationDate.fromJson(String json) : this.fromDate(dateFormat.parse(json));

  @override
  String toString() => dateFormat.format(this);
  String toJson() => toString();

  int get expiresInDays => difference(ExpirationDate.today()).inDays;

  bool get isExpired => isBefore(ExpirationDate.today());

  ExpirationDate addDays(int days) =>
      ExpirationDate.fromDate(super.add(Duration(days: days)));
}
