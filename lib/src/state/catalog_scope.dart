import 'package:flutter/material.dart';

import 'catalog_controller.dart';

class CatalogScope extends InheritedNotifier<CatalogController> {
  const CatalogScope({
    super.key,
    required CatalogController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static CatalogController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CatalogScope>();
    assert(scope != null, 'CatalogScope not found in widget tree');
    return scope!.notifier!;
  }
}

