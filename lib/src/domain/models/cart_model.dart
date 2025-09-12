import 'package:shopping_with_riverpod/src/domain/models/item_model.dart';

class Cart {
  const Cart([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<String, int> items;
  /// Note: ProductID is just a String
}

/// Helper extension used to mutate the items in the shopping cart.
extension MutableCart on Cart {
  // implementations omitted for brevity
  Cart addItem(Item item) {
    final currentQuantity = items[item.productId] ?? 0;
    final updatedItems = Map<String, int>.from(items);
    updatedItems[item.productId] = currentQuantity + item.quantity;
    return Cart(updatedItems);
  }
  Cart setItem(Item item) {
    final updatedItems = Map<String, int>.from(items);
    updatedItems[item.productId] = item.quantity;
    return Cart(updatedItems);
  }
  Cart removeItemById(String productId) {
    final updatedItems = Map<String, int>.from(items);
    updatedItems.remove(productId);
    return Cart(updatedItems);
  }
}