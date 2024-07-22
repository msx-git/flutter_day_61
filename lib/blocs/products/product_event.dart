part of 'product_bloc.dart';

sealed class ProductEvent {}

final class GetProductsEvent extends ProductEvent {}

final class AddProductsEvent extends ProductEvent {
  final String title;
  final num price;
  final String description;
  final int categoryId;
  final List images;

  AddProductsEvent({
    required this.title,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.images,
  });
}

final class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});
}
