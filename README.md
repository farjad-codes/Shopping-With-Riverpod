```
lib/
├── main.dart
├── app.dart
├── src/
│   ├── constants/
│   │   ├── app_sizes.dart
│   │   ├── breakpoints.dart
│   │   └── test_products.dart
│   ├── exceptions/
│   │   ├── app_exception.dart
│   │   └── async_error_logger.dart
│   ├── features/
│   │   ├── authentication/
│   │   │   ├── data/
│   │   │   │   ├── auth_repository.dart
│   │   │   │   └── fake_auth_repository.dart
│   │   │   ├── domain/
│   │   │   │   └── app_user.dart
│   │   │   └── presentation/
│   │   │       ├── account/
│   │   │       │   └── account_screen.dart
│   │   │       ├── sign_in/
│   │   │       │   └── email_password_sign_in_screen.dart
│   │   │       └── auth_widget.dart
│   │   ├── cart/
│   │   │   ├── application/
│   │   │   │   └── cart_service.dart
│   │   │   ├── data/
│   │   │   │   ├── local/
│   │   │   │   │   └── local_cart_repository.dart
│   │   │   │   └── remote/
│   │   │   │       └── remote_cart_repository.dart
│   │   │   ├── domain/
│   │   │   │   └── cart.dart
│   │   │   └── presentation/
│   │   │       ├── add_to_cart/
│   │   │       │   └── add_to_cart_widget.dart
│   │   │       ├── cart_screen/
│   │   │       │   └── cart_screen.dart
│   │   │       └── shopping_cart/
│   │   │           └── shopping_cart_screen.dart
│   │   ├── checkout/
│   │   │   ├── application/
│   │   │   │   └── checkout_service.dart
│   │   │   ├── data/
│   │   │   │   └── fake_checkout_repository.dart
│   │   │   ├── domain/
│   │   │   │   └── order.dart
│   │   │   └── presentation/
│   │   │       ├── checkout_screen/
│   │   │       │   └── checkout_screen.dart
│   │   │       └── payment/
│   │   │           └── payment_page.dart
│   │   ├── orders/
│   │   │   ├── data/
│   │   │   │   └── fake_orders_repository.dart
│   │   │   ├── domain/
│   │   │   │   └── order.dart
│   │   │   └── presentation/
│   │   │       ├── orders_list/
│   │   │       │   └── orders_list_screen.dart
│   │   │       └── order_item_list_tile.dart
│   │   └── products/
│   │       ├── data/
│   │       │   └── fake_products_repository.dart
│   │       ├── domain/
│   │       │   └── product.dart
│   │       └── presentation/
│   │           ├── home_app_bar/
│   │           │   └── home_app_bar.dart
│   │           ├── product_screen/
│   │           │   └── product_screen.dart
│   │           └── products_list/
│   │               └── products_list_screen.dart
│   ├── routing/
│   │   ├── app_router.dart
│   │   ├── go_router_refresh_stream.dart
│   │   └── not_found_screen.dart
│   ├── localization/
│   │   ├── app_localizations.dart
│   │   └── string_hardcoded.dart
│   ├── utils/
│   │   ├── async_value_ui.dart
│   │   ├── currency_formatter.dart
│   │   └── date_formatter.dart
│   └── common_widgets/
│       ├── alert_dialogs.dart
│       ├── async_value_widget.dart
│       ├── custom_image.dart
│       ├── decoration_image_widget.dart
│       ├── empty_placeholder_widget.dart
│       ├── item_quantity_selector.dart
│       ├── primary_button.dart
│       └── responsive_center.dart
```