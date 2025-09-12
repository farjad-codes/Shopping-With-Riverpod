import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/product_api.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';

final productApiProvider = Provider((ref) => ProductApi());
final productRepositoryProvider = Provider(
  (ref) => ProductRepositoryImpl(ref.watch(productApiProvider)),
);

final productsProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getProducts();
});
