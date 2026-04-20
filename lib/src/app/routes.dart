import 'package:flutter/material.dart';

import '../models/product.dart';
import '../ui/screens/cart_screen.dart';
import '../ui/screens/product_detail_screen.dart';
import '../ui/screens/product_list_screen.dart';

abstract final class AppRoutes {
  static const productList = '/products';
  static const productDetail = '/products/detail';
  static const cart = '/cart';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productList:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProductListScreen(),
        );
      case productDetail:
        final args = settings.arguments;
        if (args is Product) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductDetailScreen(product: args),
          );
        }
        return _invalidArgs(settings);
      case cart:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartScreen(),
        );
      default:
        return _unknown(settings);
    }
  }

  static Route<dynamic> _unknown(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Sayfa bulunamadı')),
        body: Center(child: Text('Route: ${settings.name ?? '(null)'}')),
      ),
    );
  }

  static Route<dynamic> _invalidArgs(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(child: Text('Geçersiz route argümanı')),
      ),
    );
  }
}

