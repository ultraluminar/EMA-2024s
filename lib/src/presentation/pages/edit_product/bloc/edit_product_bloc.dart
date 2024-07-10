import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/data/products_api/src/models/models.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc({
    required ProductsRepository productsRepository,
    this.product,
  })  : _productsRepository = productsRepository,
        super(product == null
            ? const EditProductState()
            : EditProductState.fromProduct(product: product)) {
    on<EditProductNameChanged>(_onNameChanged);
    on<EditProductExpiresAtChanged>(_onExpiresAtChanged);
    on<EditProductExpiresDaysAfterOpen>(_onExpiresDaysAfterOpen);
    on<EditProductSubmitted>(_onSubmitted);
  }

  final ProductsRepository _productsRepository;
  final Product? product;

  void _onNameChanged(
    EditProductNameChanged event,
    Emitter<EditProductState> emit,
  ) =>
      emit(state.copyWith(name: event.name));

  void _onExpiresAtChanged(
    EditProductExpiresAtChanged event,
    Emitter<EditProductState> emit,
  ) =>
      emit(state.copyWith(expiresAt: event.expiresAt));

  void _onExpiresDaysAfterOpen(
    EditProductExpiresDaysAfterOpen event,
    Emitter<EditProductState> emit,
  ) =>
      emit(state.copyWith(expiresDaysAfterOpen: event.expiresDaysAfterOpen));

  Future<void> _onSubmitted(
    EditProductSubmitted event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(status: EditProductStatus.loading));

    final product = (this.product == null)
        ? Product(name: state.name, expiresAt: state.expiresAt!)
        : this.product!.copyWith(name: state.name, expiresAt: state.expiresAt!);
    try {
      await _productsRepository.saveProduct(product);
      emit(state.copyWith(status: EditProductStatus.success));
    } catch (_) {
      emit(state.copyWith(status: EditProductStatus.failure));
    }
  }
}
