import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../application/cart_service.dart';
import '../../domain/models/item_model.dart';

class ShoppingCartItemController extends StateNotifier<AsyncValue<void>> {
  ShoppingCartItemController({required this.cartService})
      : super(const AsyncData(null));
  final CartService cartService;

  Future<void> updateQuantity(Item item, int quantity) async {
    // set loading state
    state = const AsyncLoading();
    // create an updated Item with the new quantity
    final updated = Item(productId: item.productId, quantity: quantity);
    // use the cartService to update the cart
    // and set the state again (data or error)
    state = await AsyncValue.guard(
      () => cartService.updateItemIfExists(updated),
    );
  }

  Future<void> deleteItem(Item item) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => cartService.removeItemById(item.productId),
    );
  }
}
