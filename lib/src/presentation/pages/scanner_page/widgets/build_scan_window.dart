import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'widgets.dart';

Widget buildScanWindow(
    Rect scanWindowRect, MobileScannerController controller) {
  return ValueListenableBuilder(
    valueListenable: controller,
    builder: (context, value, child) {
      // Not ready.
      if (!value.isInitialized ||
          !value.isRunning ||
          value.error != null ||
          value.size.isEmpty) {
        return const SizedBox();
      }

      return CustomPaint(
        painter: ScannerOverlay(scanWindowRect),
      );
    },
  );
}
