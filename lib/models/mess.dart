class Mess {
  final String id;
  final String name;
  final String address;
  final double rating;
  final List<MenuItem> menuItems;
  final List<ThaliOption> thaliOptions;
  final bool isFavorite;
  final String imageUrl;

  Mess({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.menuItems,
    required this.thaliOptions,
    this.isFavorite = false,
    required this.imageUrl,
  });

  Mess copyWith({
    String? id,
    String? name,
    String? address,
    double? rating,
    List<MenuItem>? menuItems,
    List<ThaliOption>? thaliOptions,
    bool? isFavorite,
    String? imageUrl,
  }) {
    return Mess(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      menuItems: menuItems ?? this.menuItems,
      thaliOptions: thaliOptions ?? this.thaliOptions,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({
    required this.name,
    required this.price,
  });
}

class ThaliOption {
  final String name;
  final double price;

  ThaliOption({
    required this.name,
    required this.price,
  });
} 