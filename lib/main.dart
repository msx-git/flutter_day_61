import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_61/data/repositories/products_repository.dart';
import 'package:flutter_day_61/data/services/dio_products_service.dart';

import 'blocs/products/product_bloc.dart';
import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dioProductService = DioProductsService();

  runApp(
    RepositoryProvider(
      create: (context) => ProductsRepository(
        dioProductsService: dioProductService,
      ),
      child: BlocProvider(
        create: (context) => ProductBloc(
          productsRepository: context.read<ProductsRepository>(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}
