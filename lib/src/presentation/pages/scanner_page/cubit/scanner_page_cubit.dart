import 'package:bloc/bloc.dart';

class ScannerPageCubit extends Cubit<String> {
  ScannerPageCubit() : super("Scan einen Barcode!");

  void setDisplayText(String text) => emit(text);
}
