import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../state/cart_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/banner.png',
              fit: BoxFit.cover,
              height: 160,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Haftalık eğitim projesi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            'Widget yapısı, sayfa geçişleri, modelleme, listeleme ve basit state örneği.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.productList),
            icon: const Icon(Icons.grid_view_rounded),
            label: const Text('Ürünleri Gör'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sepet: ürün ekle/çıkar (simülasyon)')),
              );
            },
            icon: const Icon(Icons.info_outline),
            label: const Text('Proje Hakkında'),
          ),
        ],
      ),
    );
  }
}

