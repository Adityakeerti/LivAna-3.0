import 'package:flutter/material.dart';
import '../../models/grocery_store.dart';
import '../../widgets/grocery_store_card.dart';
import '../../widgets/grocery_item_card.dart';

class GroceryScreen extends StatefulWidget {
  @override
  _GroceryScreenState createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryStore> stores = [
    GroceryStore(
      id: '1',
      name: 'Fresh Mart',
      address: '123 Market Street, City',
      rating: 4.5,
      items: [
        GroceryItem(name: 'Milk', price: 50, category: 'Dairy', unit: '1L'),
        GroceryItem(name: 'Bread', price: 30, category: 'Bakery', unit: '1 loaf'),
        GroceryItem(name: 'Eggs', price: 60, category: 'Dairy', unit: '12 pcs'),
        GroceryItem(name: 'Rice', price: 80, category: 'Grains', unit: '1kg'),
        GroceryItem(name: 'Apples', price: 120, category: 'Fruits', unit: '1kg'),
      ],
      imageUrl: '',
    ),
    GroceryStore(
      id: '2',
      name: 'Super Grocer',
      address: '456 Shopping Avenue, City',
      rating: 4.2,
      items: [
        GroceryItem(name: 'Potatoes', price: 40, category: 'Vegetables', unit: '1kg'),
        GroceryItem(name: 'Onions', price: 30, category: 'Vegetables', unit: '1kg'),
        GroceryItem(name: 'Tomatoes', price: 50, category: 'Vegetables', unit: '1kg'),
        GroceryItem(name: 'Cooking Oil', price: 150, category: 'Cooking', unit: '1L'),
        GroceryItem(name: 'Sugar', price: 45, category: 'Baking', unit: '1kg'),
      ],
      imageUrl: '',
    ),
    GroceryStore(
      id: '3',
      name: 'Organic Corner',
      address: '789 Green Lane, City',
      rating: 4.7,
      items: [
        GroceryItem(name: 'Organic Milk', price: 80, category: 'Dairy', unit: '1L'),
        GroceryItem(name: 'Organic Eggs', price: 100, category: 'Dairy', unit: '12 pcs'),
        GroceryItem(name: 'Organic Rice', price: 120, category: 'Grains', unit: '1kg'),
        GroceryItem(name: 'Organic Apples', price: 180, category: 'Fruits', unit: '1kg'),
        GroceryItem(name: 'Organic Honey', price: 200, category: 'Sweeteners', unit: '500g'),
      ],
      imageUrl: '',
    ),
  ];

  Map<String, int> cartItems = {};
  int totalItems = 0;
  double totalAmount = 0;
  final double discount = 50.0;

  void _toggleFavorite(String storeId) {
    setState(() {
      stores = stores.map((store) {
        if (store.id == storeId) {
          return store.copyWith(isFavorite: !store.isFavorite);
        }
        return store;
      }).toList();
    });
  }

  void _updateCart(String itemName, int quantity, double price) {
    setState(() {
      cartItems[itemName] = quantity;
      totalItems = cartItems.values.fold(0, (sum, quantity) => sum + quantity);
      _calculateTotal();
    });
  }

  void _calculateTotal() {
    totalAmount = 0;
    cartItems.forEach((itemName, quantity) {
      // Find the price of the item
      for (var store in stores) {
        var item = store.items.firstWhere(
          (i) => i.name == itemName,
          orElse: () => GroceryItem(name: '', price: 0, category: '', unit: ''),
        );
        if (item.name.isNotEmpty) {
          totalAmount += item.price * quantity;
          break;
        }
      }
    });
  }

  void _showItemsDialog(GroceryStore store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Available Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                ...store.items.map((item) => GroceryItemCard(
                      itemName: item.name,
                      price: item.price,
                      category: item.category,
                      unit: item.unit,
                      quantity: cartItems[item.name] ?? 0,
                      onIncrement: () {
                        _updateCart(item.name, (cartItems[item.name] ?? 0) + 1, item.price);
                        setModalState(() {});
                      },
                      onDecrement: () {
                        _updateCart(item.name, (cartItems[item.name] ?? 0) - 1, item.price);
                        setModalState(() {});
                      },
                    )),
                SizedBox(height: 20),
                if (totalAmount > 0) ...[
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '-₹${discount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${(totalAmount - discount).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Close Menu',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Stores'),
        backgroundColor: Colors.deepPurple,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Your Cart'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...cartItems.entries.map((entry) {
                              if (entry.value > 0) {
                                // Find the price of the item
                                double itemPrice = 0;
                                for (var store in stores) {
                                  var item = store.items.firstWhere(
                                    (i) => i.name == entry.key,
                                    orElse: () => GroceryItem(name: '', price: 0, category: '', unit: ''),
                                  );
                                  if (item.name.isNotEmpty) {
                                    itemPrice = item.price;
                                    break;
                                  }
                                }
                                return ListTile(
                                  title: Text(entry.key),
                                  subtitle: Text('₹${itemPrice.toStringAsFixed(2)} each'),
                                  trailing: Text('${entry.value}'),
                                );
                              }
                              return SizedBox.shrink();
                            }).toList(),
                            if (totalAmount > 0) ...[
                              Divider(),
                              ListTile(
                                title: Text('Subtotal'),
                                trailing: Text('₹${totalAmount.toStringAsFixed(2)}'),
                              ),
                              ListTile(
                                title: Text(
                                  'Discount',
                                  style: TextStyle(color: Colors.green),
                                ),
                                trailing: Text(
                                  '-₹${discount.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                trailing: Text(
                                  '₹${(totalAmount - discount).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      totalItems.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: GroceryStoreCard(
              store: store,
              onFavoritePressed: () => _toggleFavorite(store.id),
              onCardPressed: () => _showItemsDialog(store),
            ),
          );
        },
      ),
    );
  }
}
