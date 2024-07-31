import 'package:bloc/bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';

class ScannerPageCubit extends Cubit<String> {
  ScannerPageCubit() : super(S().scannerPageDisplayText);

  void setDisplayText(String text) => emit(text);
}
