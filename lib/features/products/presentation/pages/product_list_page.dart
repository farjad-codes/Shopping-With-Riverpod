import 'dart:developer';

import '../../../../headers.dart';
import '../../application/providers/product_providers.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () => ref.read(refreshProductListProvider)(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];
            log('Product: ${p.toJson()}');
            return ListTile(
              leading: p.imageUrl != null
                  ? Image.network(
                      p.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image),
              title: Text(p.title ?? 'No Title'),
              subtitle: Text('\$${p.price?.toStringAsFixed(2) ?? "0.00"}'),
              onTap: () {
                context.pushNamed(
                  AppRouteNames.productDetail,
                  pathParameters: {'id': products[index].id.toString()},
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
