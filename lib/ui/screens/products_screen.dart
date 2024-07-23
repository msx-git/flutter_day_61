import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/products/product_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>()..add(GetProductsEvent()),
        builder: (context, state) {
          if (state is InitialProductState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadingProductState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorProductState) {
            return Center(child: Text(state.errorMessage));
          }
          final products = (state as LoadedProductState).products;
          return products.isEmpty
              ? const Center(
                  child: Text("No Products"),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                    EditProductEvent(
                                      id: product.id.toString(),
                                      title: "New edited title",
                                      price: 1000,
                                      description: "New edited description",
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                    DeleteProductEvent(
                                      id: product.id.toString(),
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductBloc>().add(
                AddProductsEvent(
                  title: "New Product",
                  price: 150,
                  description: "A description",
                  categoryId: 1,
                  images: ["https://placeimg.com/640/480/any"],
                ),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
