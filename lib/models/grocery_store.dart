class GroceryStore {
  final String id;
  final String name;
  final String address;
  final double rating;
  final List<GroceryItem> items;
  final bool isFavorite;
  final String imageUrl;

  GroceryStore({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.items,
    this.isFavorite = false,
    required this.imageUrl,
  });

  GroceryStore copyWith({
    String? id,
    String? name,
    String? address,
    double? rating,
    List<GroceryItem>? items,
    bool? isFavorite,
    String? imageUrl,
  }) {
    return GroceryStore(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      items: items ?? this.items,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class GroceryItem {
  final String name;
  final double price;
  final String category;
  final String unit;

  GroceryItem({
    required this.name,
    required this.price,
    required this.category,
    required this.unit,
  });
} 