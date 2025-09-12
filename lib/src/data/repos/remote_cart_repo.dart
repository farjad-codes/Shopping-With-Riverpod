import 'package:shopping_with_riverpod/src/domain/models/item_model.dart';

import '../../domain/models/cart_model.dart';

abstract class RemoteCartRepository {
  // get the cart value (read-once)
  Future<Cart> fetchCart(String uid);

  // get the cart value (realtime updates)
  Stream<Cart> watchCart(String uid);

  // set the cart value
  Future<void> setCart(String uid, Cart items);

  Future<void> addToCart(Item item) async {}

  Future<void> removeFromCart(Item item) async {}

  Future getCartItems() async {}
}
