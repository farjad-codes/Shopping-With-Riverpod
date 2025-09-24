import '../../domain/entities/product.dart';
import '../datasources/product_api.dart';

class ProductRepositoryImpl {
  final ProductApi api;
  ProductRepositoryImpl(this.api);

  Future<List<Product>> getProducts() => api.fetchProducts();

  Future<Product> getProductById(String id) => api.fetchProductById(id);
}
