import 'package:dio/dio.dart';
import '../../../../headers.dart';
import '../../data/datasources/product_api.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  return ProductRepositoryImpl(ProductApi(dio));
});

final productListProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getProducts();
});

//Refresh product list
final refreshProductListProvider = Provider<void Function()>((ref) {
  return () {
    ref.refresh(productListProvider);
  };
});

final productDetailProvider = FutureProvider.family<Product, String>((ref, id) {
  return ref.watch(productRepositoryProvider).getProductById(id);
});
