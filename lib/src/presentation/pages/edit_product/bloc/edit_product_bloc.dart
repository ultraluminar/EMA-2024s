import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/shared/app_utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc({
    required ProductsRepository productsRepository,
    required Product? initialProduct,
  })  : _productsRepository = productsRepository,
        super(EditProductState(initialProduct: initialProduct)) {
    on<EditProductNameChanged>(_onNameChanged);
    on<EditProductExpiresAtChanged>(_onExpiresAtChanged);
    on<EditProductStoredAtChanged>(_onStoredAtChanged);
    on<EditProductOwnerChanged>(_onOwnerChanged);
    on<EditProductTagsChanged>(_onTagsChanged);
    on<EditProductSubmitted>(_onSubmitted);
  }

  final ProductsRepository _productsRepository;

  void _onNameChanged(
    EditProductNameChanged event,
    Emitter<EditProductState> emit,
  ) {
    emit(state.copyWith(product: state.product.copyWith(name: event.name)));
  }

  void _onExpiresAtChanged(
    EditProductExpiresAtChanged event,
    Emitter<EditProductState> emit,
  ) {
    emit(state.copyWith(
      product: state.product.copyWith(expires_at: event.expiresAt),
      expriredAtPicked: true,
    ));
  }

  void _onStoredAtChanged(
    EditProductStoredAtChanged event,
    Emitter<EditProductState> emit,
  ) {
    emit(state.copyWith(
        product: state.product.copyWith(stored_at: event.storedAt)));
  }

  void _onOwnerChanged(
    EditProductOwnerChanged event,
    Emitter<EditProductState> emit,
  ) {
    emit(state.copyWith(product: state.product.copyWith(owner: event.owner)));
  }

  void _onTagsChanged(
    EditProductTagsChanged event,
    Emitter<EditProductState> emit,
  ) {
    emit(state.copyWith(product: state.product.copyWith(tags: event.tags)));
  }

  Future<void> _onSubmitted(
    EditProductSubmitted event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(status: EditProductStatus.loading));
    try {
      await _productsRepository.saveProduct(state.product);
      emit(state.copyWith(status: EditProductStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditProductStatus.failure));
    }
  }
}
