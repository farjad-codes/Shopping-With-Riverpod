class Product {
  int? id;
  String? title;
  String? description;
  String? imageUrl;
  double? price;
  String? categoryName;
  List<dynamic>? reviews;

  Product({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.categoryName,
    this.reviews,
  });

  Product.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
    if (json["price"] is double) {
      price = json["price"];
    }
    if (json["categoryName"] is String) {
      categoryName = json["categoryName"];
    }
    if (json["reviews"] is List) {
      reviews = json["reviews"] ?? [];
    }
  }

  static List<Product> fromList(List<Map<String, dynamic>> list) {
    return list.map(Product.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["imageUrl"] = imageUrl;
    _data["price"] = price;
    _data["categoryName"] = categoryName;
    if (reviews != null) {
      _data["reviews"] = reviews;
    }
    return _data;
  }
}
