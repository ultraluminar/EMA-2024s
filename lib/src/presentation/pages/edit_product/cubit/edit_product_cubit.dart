import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({
    required this.productsRepository,
    required ProductPrototype productPrototype,
  }) : super(EditProductState(productPrototype: productPrototype));

  final ProductsRepository productsRepository;

  bool get isNewProduct => state.productPrototype.uuid == null;

  void setName(String name) {
    log("setName: $name");
    emit(state.copyWith(
        productPrototype: state.productPrototype.copyWith(name: name)));
  }

  void setExpiresAt(DateTime date) {
    log("setDate: $date");
    emit(state.copyWith(
        productPrototype: state.productPrototype
            .copyWith(expiresAt: ExpirationDate.fromDate(date))));
  }

  void setStatus(Status status) {
    log("setStatus: $status");
    emit(state.copyWith(status: status));
  }

  Future<void> submit() async {
    log("submit");
    setStatus(Status.loading);

    final product = state.productPrototype.toProduct();
    log("$product");
    final saveProduct = productsRepository.saveProduct(product);

    await saveProduct.then(
      (_) => setStatus(Status.success),
      onError: (_) => setStatus(Status.failure),
    );
  }
}
