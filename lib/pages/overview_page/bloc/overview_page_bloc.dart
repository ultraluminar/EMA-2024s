import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_api/products_api.dart';

part 'overview_page_event.dart';
part 'overview_page_state.dart';

class OverviewPageBloc extends Bloc<OverviewPageEvent, OverviewPageState> {
  OverviewPageBloc() : super(OverviewPageInitial()) {
    on<OverviewPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
