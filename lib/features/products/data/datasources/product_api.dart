class ProductApi {
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      {'id': '1', 'name': 'Apples', 'price': 1.99},
      {'id': '2', 'name': 'Bananas', 'price': 0.99},
    ];
  }
}
