import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/product_name_api/src/product_name_api.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  static Route<void> route() {
    log("route");
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const ScannerPage(),
    );
  }

  @override
  State<StatefulWidget> createState() => ScannerPageState();
}

class ScannerPageState extends State<ScannerPage> {
  Barcode? _barcode;
  late String _displayText = 'Scan something!';

  Future<String> get getDisplayText async {
    if (_barcode == null) return 'Scan something!';
    if (_barcode!.displayValue == null) return 'No display value.';
    final productName =
        await ProductNameApi.fetchFromApi(_barcode!.displayValue!);
    if (productName == null) return 'Product not found';
    return productName;
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (!mounted) return;
    final text = await getDisplayText;
    setState(() {
      _barcode = barcodes.barcodes.firstOrNull;
      _displayText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        _displayText,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
