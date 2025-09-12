
import 'package:shopping_with_riverpod/src/domain/models/item_model.dart';

import '../../domain/models/cart_model.dart';

abstract class LocalCartRepository {
  // get the cart value (read-once)
  Future<Cart> fetchCart();

  // get the cart value (realtime updates)
  Stream<Cart> watchCart();

  // set the cart value
  Future<void> setCart(Cart cart);

  Future<void> addToCart(Item item) async {}

  Future<void> removeFromCart(Item item) async {}

  Future getCartItems() async {}
}
