import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/src/presentation/pages/scanner_page/cubit/scanner_page_cubit.dart';
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

class ScannerPageView extends StatelessWidget {
  const ScannerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      body: Stack(
        children: [
          MobileScanner(
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

              if (!context.mounted) return;
              Navigator.of(context).pushReplacement(
                EditProductPage.route(name: name, barcode: barcode),
              );
            },
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
