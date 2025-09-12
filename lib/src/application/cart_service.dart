import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_with_riverpod/src/_headers.dart';

import '../domain/models/item_model.dart';
import 'providers.dart';

class CartService {
  CartService(this.ref);
  final Ref ref;

  /// fetch the cart from the local or remote repository
  /// depending on the user auth state
  Future<Cart> _fetchCart() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref.read(remoteCartRepositoryProvider).fetchCart(user.uid);
    } else {
      return ref.read(localCartRepositoryProvider).fetchCart();
    }
  }

  /// save the cart to the local or remote repository
  /// depending on the user auth state
  Future<void> _setCart(Cart cart) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref.read(remoteCartRepositoryProvider).setCart(user.uid, cart);
    } else {
      await ref.read(localCartRepositoryProvider).setCart(cart);
    }
  }

  /// adds an item to the local or remote cart
  /// depending on the user auth state
  Future<void> addItem(Item item) async {
    // 1. fetch the cart
    final cart = await _fetchCart();
    // 2. return a copy with the updated data
    final updated = cart.addItem(item);
    // 3. set the cart with the updated data
    await _setCart(updated);
  }


  /// removes an item from the local or remote cart depending on the user auth
  /// state
  Future<void> removeItemById(String productId) async {
    // business logic
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productId);
    await _setCart(updated);
  }

  /// sets an item in the local or remote cart depending on the user auth state
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  Future<void> updateItemIfExists(Item updated) async {
    final cart = await _fetchCart();
    final exists = cart.items.keys.any((key) => key == updated.productId);
    if (exists) {
      final newCart = cart.setItem(updated);
      await _setCart(newCart);
    }
  }
}
