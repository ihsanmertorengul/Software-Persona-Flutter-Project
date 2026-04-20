import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartController extends ValueNotifier<Map<int, int>> {
  CartController() : super(<int, int>{});

  bool contains(int productId) => (value[productId] ?? 0) > 0;

  int get itemCount => value.values.fold<int>(0, (sum, qty) => sum + qty);

  int quantityOf(int productId) => value[productId] ?? 0;

  void add(int productId) {
    final next = Map<int, int>.from(value);
    next.update(productId, (q) => q + 1, ifAbsent: () => 1);
    value = next;
  }

  void removeOne(int productId) {
    final next = Map<int, int>.from(value);
    final current = next[productId] ?? 0;
    if (current <= 1) {
      next.remove(productId);
    } else {
      next[productId] = current - 1;
    }
    value = next;
  }

  void removeAll(int productId) {
    if (!value.containsKey(productId)) return;
    final next = Map<int, int>.from(value)..remove(productId);
    value = next;
  }

  void toggle(int productId) {
    if (contains(productId)) {
      removeAll(productId);
    } else {
      add(productId);
    }
  }
}

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    super.key,
    required CartController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found in widget tree');
    return scope!.notifier!;
  }
}

