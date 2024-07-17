import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/src/presentation/pages/scanner_page/scanner_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart' show BarcodeValidator;

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  static Route<void> route() {
    log("route");
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) => ScannerPageCubit(),
        child: const ScannerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ScannerPageView();
  }
}

class ScannerPageView extends StatefulWidget {
  const ScannerPageView({super.key});

  @override
  State<ScannerPageView> createState() => _ScannerPageViewState();
}

class _ScannerPageViewState extends State<ScannerPageView> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      detectionTimeoutMs: const Duration(seconds: 3).inMilliseconds,
    );
    controller.start();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -100)),
      width: 350,
      height: 200,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            scanWindow: scanWindow,
            onDetect: (BarcodeCapture captures) async {
              final barcode = captures.barcodes.firstOrNull?.displayValue;
              final cubit = context.read<ScannerPageCubit>();
              if (!BarcodeValidator.isValid(barcode)) {
                cubit.setDisplayText("Das ist kein Product-Barcode!");
                return;
              }

              final name = await ProductNameApi.fetch(barcode!);
              if (name == null) {
                cubit.setDisplayText("Product nicht gefunden!");
                return;
              }

              await controller.stop();
              if (!context.mounted) return;

              await Navigator.of(context).pushReplacement(
                EditProductPage.route(
                    productPrototype: ProductPrototype.fromScan(name, barcode)),
              );
            },
          ),
          buildScanWindow(scanWindow, controller),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ToogleFlashlightButton(controller: controller),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.4),
                ),
                child: Expanded(
                  child: Center(
                    child: BlocBuilder<ScannerPageCubit, String>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) {
                        return Text(
                          state,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
