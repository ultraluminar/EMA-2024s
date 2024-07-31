import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  final today = ExpirationDate.today();
  final prototype = ProductPrototype(
    name: "RedBull",
    expiresAt: today,
    uuid: const Uuid().v4(),
  );

  group("isExpired", () {
    for (var expiresIn in [-3, -2, -1, 0, 1, 2, 3]) {
      prototype.copyWith(expiresAt: today.addDays(expiresIn));
      final product = prototype.toProduct();
      final isExpired = product.isExpired;

      test("expiresIn: $expiresIn => $isExpired", () {
        expect(isExpired, equals(expiresIn < 0));
      });
    }
  });
}
