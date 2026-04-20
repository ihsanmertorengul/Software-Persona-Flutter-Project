import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/product.dart';
import '../../state/cart_controller.dart';
import '../../state/catalog_scope.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final catalog = CatalogScope.of(context);
    final query = _searchController.text.trim().toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
        actions: [
          ValueListenableBuilder(
            valueListenable: cart,
            builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.cart),
                  child: Badge(
                    isLabelVisible: value.isNotEmpty,
                    label: Text('${cart.itemCount}'),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Ara (ürün adı / kategori)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Temizle',
                        onPressed: () => _searchController.clear(),
                        icon: const Icon(Icons.close),
                      ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: catalog,
              builder: (context, _) {
                if (catalog.isLoading && catalog.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (catalog.error != null && catalog.products.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Ürünler yüklenemedi: ${catalog.error}'),
                    ),
                  );
                }

                final all = catalog.products;
                final filtered = query.isEmpty
                    ? all
                    : all.where((p) {
                        return p.title.toLowerCase().contains(query) ||
                            p.category.toLowerCase().contains(query);
                      }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('Sonuç bulunamadı.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.of(context).pushNamed(
                        AppRoutes.productDetail,
                        arguments: product,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

