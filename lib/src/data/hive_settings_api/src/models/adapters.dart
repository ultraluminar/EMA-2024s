import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/models/models.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TimeOfDayJsonAdapter extends TypeAdapter<TimeOfDayJson> {
  @override
  final int typeId = 1;

  @override
  TimeOfDayJson read(BinaryReader reader) {
    return TimeOfDayJson.fromJson(jsonDecode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, TimeOfDayJson obj) {
    return writer.write(jsonEncode(obj.toJson()));
  }
}

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 2;

  @override
  ThemeMode read(BinaryReader reader) {
    return ThemeMode.values.byName(jsonDecode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    return writer.write(jsonEncode(obj.name));
  }
}

class ProductFilterAdapter extends TypeAdapter<ProductFilter> {
  @override
  final int typeId = 3;

  @override
  ProductFilter read(BinaryReader reader) {
    return ProductFilter.fromJson(jsonDecode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, ProductFilter obj) {
    return writer.write(jsonEncode(obj.toJson()));
  }
}

class ProductSortAdapter extends TypeAdapter<ProductSort> {
  @override
  final int typeId = 4;

  @override
  ProductSort read(BinaryReader reader) {
    return ProductSort.fromJson(jsonDecode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, ProductSort obj) {
    return writer.write(jsonEncode(obj.toJson()));
  }
}
