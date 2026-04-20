import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/product.dart';
import '../../state/cart_controller.dart';
import '../../state/catalog_scope.dart';
import '../formatters/money.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final catalog = CatalogScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([cart, catalog]),
        builder: (context, _) {
          if (catalog.isLoading && catalog.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (catalog.error != null && catalog.products.isEmpty) {
            return Center(child: Text('Ürünler yüklenemedi: ${catalog.error}'));
          }

          final entries = cart.value.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key));

          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 48),
                    const SizedBox(height: 10),
                    const Text('Sepetin boş'),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.productList,
                        (route) => route.isFirst,
                      ),
                      icon: const Icon(Icons.grid_view_rounded),
                      label: const Text('Ürünlere Git'),
                    ),
                  ],
                ),
              ),
            );
          }

          double total = 0;
          final tiles = <Widget>[];

          for (final entry in entries) {
            final productId = entry.key;
            final qty = entry.value;
            final Product? product = catalog.byId(productId);
            if (product == null) continue;

            total += product.price * qty;

            tiles.add(
              Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: ProductImage(source: product.image),
                    ),
                  ),
                  title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text('${formatTry(product.price)} • $qty adet'),
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.productDetail,
                    arguments: product,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Azalt',
                        onPressed: () => cart.removeOne(product.id),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$qty', style: Theme.of(context).textTheme.titleSmall),
                      IconButton(
                        tooltip: 'Arttır',
                        onPressed: () => cart.add(product.id),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                      IconButton(
                        tooltip: 'Kaldır',
                        onPressed: () => cart.removeAll(product.id),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  children: tiles,
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Toplam',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formatTry(total),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Satın alma akışı eğitim kapsamı dışında (simülasyon).')),
                          );
                        },
                        child: const Text('Satın Al (Simülasyon)'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

