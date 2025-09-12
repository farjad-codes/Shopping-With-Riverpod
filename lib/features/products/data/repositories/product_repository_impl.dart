import '../../domain/entities/product.dart';
import '../datasources/product_api.dart';

class ProductRepositoryImpl {
  final ProductApi api;
  ProductRepositoryImpl(this.api);

  Future<List<Product>> getProducts() async {
    final data = await api.fetchProducts();
    return data.map((d) =>
      Product(id: d['id'], name: d['name'], price: d['price'])
    ).toList();
  }
}
