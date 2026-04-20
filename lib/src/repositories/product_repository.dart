import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';
import '../services/catalog_api.dart';

class ProductRepository {
  ProductRepository({
    CatalogApi? api,
    this.seedAssetPath = 'assets/data/products_seed.json',
  }) : _api = api ?? const CatalogApi();

  final CatalogApi _api;
  final String seedAssetPath;

  Future<List<Product>> fetchProducts() async {
    try {
      final raw = await _api.fetchProductsRaw();
      final products = raw.map(Product.fromJson).where((p) => p.id != 0 && p.title.isNotEmpty).toList();
      if (products.isNotEmpty) return products;
    } catch (_) {
      // Network optional for training; fall back to local assets.
    }
    return _loadSeedProducts();
  }

  Future<List<Product>> _loadSeedProducts() async {
    final jsonText = await rootBundle.loadString(seedAssetPath);
    final decoded = jsonDecode(jsonText);
    if (decoded is! List) return const [];
    return decoded.whereType<Map>().map((e) => Product.fromJson(e.cast<String, dynamic>())).toList();
  }
}

