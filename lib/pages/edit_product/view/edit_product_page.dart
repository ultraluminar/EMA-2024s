import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/pages/edit_product/edit_product.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  static Route<void> route({Product? initialProduct}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditProductBloc(
          productRepository: context.read<ProductsRepository>(),
          initialProduct: initialProduct,
        ),
        child: const EditProductPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductBloc, EditProductState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditProductStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditProductView(),
    );
  }
}

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditProductBloc bloc) => bloc.state.status);
    final isNewProduct = context.select(
      (EditProductBloc bloc) => bloc.state.isNewProduct,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewProduct
              ? 'Add Product'
              : 'Edit Product',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save Product',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<EditProductBloc>().add(const EditProductSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CircularProgressIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: const Placeholder(),
    );
  }
}
        
