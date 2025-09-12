/// A product along with a quantity that can be added to an order/cart
class Item {
  const Item({
    required this.productId,
    required this.quantity,
  });
  final String productId;
  final int quantity;
}