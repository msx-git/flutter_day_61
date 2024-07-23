import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../data/models/product.dart';
import '../../data/repositories/products_repository.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository _productsRepository;

  ProductBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(InitialProductState()) {
    on<GetProductsEvent>(_getProducts);
    on<AddProductsEvent>(_addProduct);
    on<EditProductEvent>(_editProduct);

    on<DeleteProductEvent>(_deleteProduct);
  }

  void _getProducts(GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductState());

    try {
      final response = await _productsRepository.getProducts();
      emit(LoadedProductState(products: response));
    } on DioException catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }

  void _addProduct(AddProductsEvent event, Emitter<ProductState> emit) async {
    final products = (state as LoadedProductState).products;

    emit(LoadingProductState());

    try {
      final addedProduct = await _productsRepository.addProduct(
        title: event.title,
        price: event.price,
        description: event.description,
        categoryId: event.categoryId,
        images: event.images,
      );
      products.add(addedProduct);

      emit(LoadedProductState(products: products));
    } on DioException catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }

  void _editProduct(event, emit) async {
    final products = (state as LoadedProductState).products;

    emit(LoadingProductState());

    try {
      final editedProduct = await _productsRepository.editProduct(
        id: event.id,
        title: event.title,
        price: event.price,
        description: event.description,
      );
      for (var product in products) {
        if (product.id == event.id) {
          product.title = editedProduct.title;
          product.price = editedProduct.price;
          product.description = editedProduct.description;
        }
      }

      emit(LoadedProductState(products: products));
    } on DioException catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }

  void _deleteProduct(event, emit) async {
    final products = (state as LoadedProductState).products;

    emit(LoadingProductState());

    try {
      await _productsRepository.deleteProduct(id: event.id);

      products.removeWhere((product) => product.id == event.id);

      emit(LoadedProductState(products: products));
    } on DioException catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }
}
