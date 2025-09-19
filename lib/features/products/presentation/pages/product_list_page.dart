import '../../../../headers.dart';
import '../../../auth/application/providers/auth_notifier.dart'
    show authNotifierProvider;
import '../../application/providers/product_providers.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
              context.goNamed(AppRouteNames.onboarding);
            },
          ),
        ],
      ),
      body: asyncProducts.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(products[i].name),
            subtitle: Text('\$${products[i].price}'),
            onTap: () {
              context.pushNamed(
                AppRouteNames.productDetail,
                pathParameters: {'id': products[i].id.toString()},
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
