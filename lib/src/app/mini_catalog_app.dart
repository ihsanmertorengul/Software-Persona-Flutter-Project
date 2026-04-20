import 'package:flutter/material.dart';

import '../state/cart_controller.dart';
import '../state/catalog_controller.dart';
import '../state/catalog_scope.dart';
import '../ui/screens/home_screen.dart';
import 'routes.dart';

class MiniCatalogApp extends StatefulWidget {
  const MiniCatalogApp({super.key});

  @override
  State<MiniCatalogApp> createState() => _MiniCatalogAppState();
}

class _MiniCatalogAppState extends State<MiniCatalogApp> {
  final CartController _cart = CartController();
  final CatalogController _catalog = CatalogController();

  @override
  void initState() {
    super.initState();
    _catalog.load();
  }

  @override
  void dispose() {
    _cart.dispose();
    _catalog.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5));

    return CatalogScope(
      controller: _catalog,
      child: CartScope(
        controller: _cart,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mini Katalog',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: colorScheme,
            appBarTheme: const AppBarTheme(centerTitle: false),
            cardTheme: CardThemeData(
  elevation: 0,
  color: colorScheme.surface,
  margin: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: BorderSide(color: colorScheme.outlineVariant),
  ),
),
          ),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

