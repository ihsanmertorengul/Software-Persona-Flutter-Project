class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;

  factory Product.fromJson(Map<String, dynamic> json) {
    final title = (json['title'] ?? json['name'] ?? json['productName'] ?? '').toString();
    final description = (json['description'] ?? json['desc'] ?? json['detail'] ?? '').toString();
    final category = (json['category'] ?? json['cat'] ?? json['type'] ?? '').toString();

    final image = (json['image'] ??
            json['imageUrl'] ??
            json['img'] ??
            json['thumbnail'] ??
            json['photo'] ??
            json['picture'] ??
            '')
        .toString();

    return Product(
      id: _asInt(json['id']),
      title: title,
      description: description,
      price: _asDouble(json['price'] ?? json['amount'] ?? json['cost']),
      image: image.trim().isEmpty ? 'assets/images/banner.png' : image,
      category: category,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'category': category,
      };

  static int _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _asDouble(Object? value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}

