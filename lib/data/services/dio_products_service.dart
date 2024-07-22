import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/config/dio_client.dart';
import '../models/category.dart';
import '../models/product.dart';

class DioProductsService {
  final _dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dioClient.get(url: "/products");

      List<Product> products = [];

      for (var product in response.data) {
        if (true) {
          products.add(Product.fromJson(product));
        }
      }

      return products;
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Product> addProduct({
    required String title,
    required num price,
    required String description,
    required int categoryId,
    required List images,
  }) async {
    try {
      final mapData = {
        "title": title,
        "price": price,
        "description": description,
        "categoryId": categoryId,
        "images": images
      };
      final response = await _dioClient.post(url: "/products/", data: mapData);
      final newProduct = Product(
        id: response.data['id'],
        title: response.data['title'],
        price: response.data['price'],
        description: response.data['description'],
        images: response.data['images'],
        creationAt: response.data['creationAt'],
        updatedAt: response.data['updatedAt'],
        category: Kategory.fromJson(response.data['category']),
      );
      return newProduct;
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteProduct({required String id}) async {
    try {
      final response = await _dioClient.delete(url: "/products/$id");
      print(response);
    } on DioException catch (e) {
      debugPrint(e.response?.data);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
