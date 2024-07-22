import 'package:flutter_day_61/data/services/dio_products_service.dart';

import '../models/product.dart';

class ProductsRepository {
  final DioProductsService _dioProductsService;

  ProductsRepository({required DioProductsService dioProductsService})
      : _dioProductsService = dioProductsService;

  Future<List<Product>> getProducts() async {
    return await _dioProductsService.getProducts();
  }

  Future<Product> addProduct({
    required String title,
    required num price,
    required String description,
    required int categoryId,
    required List images,
  }) async {
    return await _dioProductsService.addProduct(
      title: title,
      price: price,
      description: description,
      categoryId: categoryId,
      images: images,
    );
  }

  Future<void> deleteProduct({required String id}) async {
    await _dioProductsService.deleteProduct(id: id);
  }
}
