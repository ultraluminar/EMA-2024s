import 'package:fridge_manager/src/data/products_api/src/models/expiration_date.dart';
import 'package:test/test.dart';

void main() {
  final expirationDate = ExpirationDate(2002, 12, 7);

  test('date should have no time', () {
    expect(expirationDate.hour, isZero);
    expect(expirationDate.minute, isZero);
    expect(expirationDate.second, isZero);
    expect(expirationDate.millisecond, isZero);
    expect(expirationDate.microsecond, isZero);
  });

  test('toJson', () {
    final String json = expirationDate.toJson();
    expect(json, equals("07.12.2002"));
  });

  test('fromJson', () {
    const String json = "07.12.2002";
    final exDate = ExpirationDate.fromJson(json);

    expect(exDate, equals(expirationDate));
    expect(exDate.millisecond, isZero);
  });

  test('expiresInDays', () {
    final today = ExpirationDate.today();
    final in3Days = today.addDays(3);

    final expiresInDays = in3Days.expiresInDays;
    expect(expiresInDays, equals(3));
  });

  group('isExpired', () {
    final today = ExpirationDate.today();

    test('today', () {
      expect(today.isExpired, isFalse);
    });

    test('expired', () {
      final yesterday = today.addDays(-1);
      expect(yesterday.isExpired, isTrue);
    });

    test('not expired', () {
      final in3Days = today.addDays(3);
      expect(in3Days.isExpired, isFalse);
    });
  });
}
