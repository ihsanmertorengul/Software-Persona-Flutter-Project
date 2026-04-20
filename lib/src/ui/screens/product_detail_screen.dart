import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../state/cart_controller.dart';
import '../formatters/money.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final inCart = cart.contains(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: 240,
              child: ProductImage(source: product.image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Chip(
                label: Text(
                  formatTry(product.price),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () {
              if (cart.contains(product.id)) {
                cart.removeAll(product.id);
              } else {
                cart.add(product.id);
              }
              final nowInCart = cart.contains(product.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(nowInCart ? 'Sepete eklendi' : 'Sepetten çıkarıldı')),
              );
            },
            icon: Icon(cart.contains(product.id) ? Icons.remove_shopping_cart : Icons.add_shopping_cart),
            label: Text(cart.contains(product.id) ? 'Sepetten Çıkar' : 'Sepete Ekle'),
          ),
        ],
      ),
    );
  }
}

