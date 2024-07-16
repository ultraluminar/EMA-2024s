// ignore_for_file: avoid_print

import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
import 'package:openfoodfacts/openfoodfacts.dart' hide Product;
import 'package:test/test.dart';

void main() async {
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: "Fridge Manager",
    version: "1.0",
    system: "Flutter",
    comment: "An app to manage product expiration dates",
  );
  OpenFoodAPIConfiguration.globalLanguages = [OpenFoodFactsLanguage.GERMAN];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;

  test("fetchProduct", () async {
    final productName = await ProductNameApi.fetchFromApi("4001686322963");
    print(productName);
    expect(productName, equals('Tropifrutti'));
  });
}
