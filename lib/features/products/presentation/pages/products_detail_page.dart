import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/product_providers.dart';
import '../../domain/entities/product.dart';

class ProductDetailPage extends ConsumerWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: productAsync.when(
        data: (product) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (product.imageUrl != null)
                Image.network(
                  product.imageUrl!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                product.title ?? 'No Title',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price?.toStringAsFixed(2) ?? "0.00"}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.green),
              ),
              const SizedBox(height: 16),
              Text(product.description ?? 'No Description'),
              const SizedBox(height: 24),
              Text(
                'Category: ${product.categoryName ?? "N/A"}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              if (product.reviews != null && product.reviews!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reviews:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...product.reviews!
                        .map((r) => Text('- ${r.toString()}'))
                        .toList(),
                  ],
                ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
