import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc({
    required ProductsRepository productRepository,
    required Product? initialProduct,
  })  : _productRepository = productRepository,
        super(
          EditProductState(
            initialProduct: initialProduct,
            name: initialProduct?.name ?? "Product Name", // TODO: implement default value
            expiresAt: initialProduct?.expires_at,
            storedAt: initialProduct?.stored_at,
            owner: initialProduct?.owner ?? "",
            tags: initialProduct?.tags ?? [],
          ),
        ) {
    on<EditProductNameChanged>(_onNameChanged);
    on<EditProductExpiresAtChanged>(_onExpiresAtChanged);
    on<EditProductStoredAtChanged>(_onStoredAtChanged);
    on<EditProductOwnerChanged>(_onOwnerChanged);
    on<EditProductTagsChanged>(_onTagsChanged);
    on<EditProductSubmitted>(_onSubmitted);
  }

  final ProductsRepository _productRepository;

  void _onNameChanged(
      EditProductNameChanged event, Emitter<EditProductState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onExpiresAtChanged(
      EditProductExpiresAtChanged event, Emitter<EditProductState> emit) {
    emit(state.copyWith(expiresAt: event.expiresAt));
  }

  void _onStoredAtChanged(
      EditProductStoredAtChanged event, Emitter<EditProductState> emit) {
    emit(state.copyWith(storedAt: event.storedAt));
  }

  void _onOwnerChanged(
      EditProductOwnerChanged event, Emitter<EditProductState> emit) {
    emit(state.copyWith(owner: event.owner));
  }

  void _onTagsChanged(
      EditProductTagsChanged event, Emitter<EditProductState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  Future<void> _onSubmitted(
      EditProductSubmitted event, Emitter<EditProductState> emit) async {
    emit(state.copyWith(status: EditProductStatus.loading));
    final Product product = state.isNewProduct
        ? Product(
            name: state.name,
            product_id: state.productId,
            expires_at: state.expiresAt,
            stored_at: state.storedAt,
            owner: state.owner,
            tags: state.tags,
          )
        : state.initialProduct!.copyWith(
            name: state.name,
            expires_at: state.expiresAt,
            stored_at: state.storedAt,
            owner: state.owner,
            tags: state.tags,
          );
    try {
      await _productRepository.saveProduct(product);
      emit(state.copyWith(status: EditProductStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditProductStatus.failure));
    }
  }
}
