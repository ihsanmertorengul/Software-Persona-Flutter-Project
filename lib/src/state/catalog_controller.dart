import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';

class CatalogController extends ChangeNotifier {
  CatalogController({ProductRepository? repository}) : _repo = repository ?? ProductRepository();

  final ProductRepository _repo;

  bool _loading = false;
  Object? _error;
  List<Product> _products = const [];

  bool get isLoading => _loading;
  Object? get error => _error;
  List<Product> get products => _products;

  Future<void> load() async {
    if (_loading) return;
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _repo.fetchProducts();
    } catch (e) {
      _error = e;
      _products = const [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Product? byId(int id) {
    for (final p in _products) {
      if (p.id == id) return p;
    }
    return null;
  }
}

