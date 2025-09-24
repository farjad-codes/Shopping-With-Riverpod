import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constant.dart';
import '../../domain/entities/product.dart';

class ProductApi {
  final Dio dio;
  ProductApi(this.dio);

  /// Fetch all products
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}/products',
        options: Options(validateStatus: (_) => true),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        log('Products fetched successfully: $data');
        return data
            .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        log(
          '❌ Failed to fetch products: ${response.statusCode} -> ${response.data}',
        );
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      log('❌ Error fetching products: $e');
      rethrow;
    }
  }

  /// Fetch product by ID
  Future<Product> fetchProductById(String id) async {
    try {
      final url = '${ApiConstants.baseUrl}/products/$id';
      log(url);
      final response = await dio.get(
        url,
        options: Options(validateStatus: (_) => true),
      );

      if (response.statusCode == 200) {
        return Product.fromJson(Map<String, dynamic>.from(response.data));
      } else {
        log(
          '❌ Failed to fetch product $id: ${response.statusCode} -> ${response.data}',
        );
        throw Exception('Failed to fetch product');
      }
    } catch (e) {
      log('❌ Error fetching product by id: $e');
      rethrow;
    }
  }
}
