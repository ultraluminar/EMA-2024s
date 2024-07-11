import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:test/test.dart';

void main() {
  final today = ExpirationDate.today();

  final product = Product(
    uuid: "0",
    name: "RedBull",
    expiresAt: today,
  );

  group("isExpired", () {
    for (var expiresIn in [-3, -2, -1, 0, 1, 2, 3]) {
      final product1 = product.copyWith(expiresAt: today.addDays(expiresIn));
      final isExpired = product1.isExpired;

      test("expiresIn: $expiresIn => $isExpired", () {
        expect(isExpired, equals(expiresIn < 0));
      });
    }
  });
}
