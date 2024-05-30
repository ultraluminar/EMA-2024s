import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge_manager/pages/products_page/products_page.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

part 'products_page_event.dart';
part 'products_page_state.dart';

class ProductsPageBloc extends Bloc<ProductsPageEvent, ProductsPageState> {
  ProductsPageBloc({
    required ProductsRepository productsRepository,
  })  : _productsRepository = productsRepository,
        super(const ProductsPageState()) {
    on<ProductsPageSubscriptionRequested>(_onSubscriptionRequested);
    on<ProductsPageFilterChanged>(_onFilterChanged);
  }

  final ProductsRepository _productsRepository;

  Future<void> _onSubscriptionRequested(
    ProductsPageSubscriptionRequested event,
    Emitter<ProductsPageState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductsPageStatus.loading));

    await emit.forEach<List<Product>>(
      _productsRepository.getAllProducts(),
      onData: (products) => state.copyWith(
        status: () => ProductsPageStatus.success,
        products: () => products,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ProductsPageStatus.failure,
      ),
    );
  }

  Future<void> _onFilterChanged(
    ProductsPageFilterChanged event,
    Emitter<ProductsPageState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }
}

// TODO: Add more Events
