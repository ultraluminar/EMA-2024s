import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge_manager/pages/overview_page/overview_page.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

part 'overview_page_event.dart';
part 'overview_page_state.dart';

class OverviewPageBloc extends Bloc<OverviewPageEvent, OverviewPageState> {
  OverviewPageBloc({
    required ProductsRepository productsRepository,
  })  : _productsRepository = productsRepository,
        super(const OverviewPageState()) {
    on<OverviewPageSubscriptionRequested>(_onSubscriptionRequested);
    on<OverviewPageFilterChanged>(_onFilterChanged);
  }

  final ProductsRepository _productsRepository;

  Future<void> _onSubscriptionRequested(
    OverviewPageSubscriptionRequested event,
    Emitter<OverviewPageState> emit,
  ) async {
    emit(state.copyWith(status: () => OverviewPageStatus.loading));

    await emit.forEach<List<Product>>(
      _productsRepository.getAllProducts(),
      onData: (products) => state.copyWith(
        status: () => OverviewPageStatus.success,
        products: () => products,
      ),
      onError: (_, __) => state.copyWith(
        status: () => OverviewPageStatus.failure,
      ),
    );
  }

  Future<void> _onFilterChanged(
    OverviewPageFilterChanged event,
    Emitter<OverviewPageState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }
}

// TODO: Add more Events
