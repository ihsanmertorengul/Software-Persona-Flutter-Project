import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
    this.placeholderAsset = 'assets/images/banner.png',
  });

  final String source;
  final BoxFit fit;
  final String placeholderAsset;

  bool get _isNetwork => source.startsWith('http://') || source.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (source.trim().isEmpty) return _fallback(context);

    if (_isNetwork) {
      return Image.network(
        source,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _fallback(context);
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(placeholderAsset, fit: fit),
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ],
          );
        },
      );
    }

    return Image.asset(
      source,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _fallback(context),
    );
  }

  Widget _fallback(BuildContext context) {
    return Image.asset(
      placeholderAsset,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest),
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}

