import 'package:flutter/material.dart';
import '../../models/mess.dart';
import '../../widgets/mess_card.dart';
import '../../widgets/menu_item_card.dart';

class MessScreen extends StatefulWidget {
  @override
  _MessScreenState createState() => _MessScreenState();
}

class _MessScreenState extends State<MessScreen> {
  List<Mess> messes = [
    Mess(
      id: '1',
      name: 'Tasty Bites Mess',
      address: '123 Food Street, City',
      rating: 4.5,
      menuItems: [
        MenuItem(name: 'Dal', price: 30),
        MenuItem(name: 'Rice', price: 25),
        MenuItem(name: 'Roti', price: 10),
        MenuItem(name: 'Sabzi', price: 40),
        MenuItem(name: 'Salad', price: 20),
      ],
      thaliOptions: [
        ThaliOption(name: 'Regular Thali', price: 100),
        ThaliOption(name: 'Special Thali', price: 150),
        ThaliOption(name: 'Mini Thali', price: 80),
      ],
      imageUrl: '',
    ),
    Mess(
      id: '2',
      name: 'Spice Garden',
      address: '456 Spice Lane, City',
      rating: 4.2,
      menuItems: [
        MenuItem(name: 'Butter Chicken', price: 180),
        MenuItem(name: 'Biryani', price: 120),
        MenuItem(name: 'Naan', price: 25),
        MenuItem(name: 'Paneer', price: 140),
        MenuItem(name: 'Raita', price: 30),
      ],
      thaliOptions: [
        ThaliOption(name: 'North Indian Thali', price: 200),
        ThaliOption(name: 'South Indian Thali', price: 180),
      ],
      imageUrl: '',
    ),
    Mess(
      id: '3',
      name: 'Home Style Mess',
      address: '789 Comfort Road, City',
      rating: 4.7,
      menuItems: [
        MenuItem(name: 'Sambar', price: 40),
        MenuItem(name: 'Idli', price: 30),
        MenuItem(name: 'Dosa', price: 50),
        MenuItem(name: 'Vada', price: 25),
        MenuItem(name: 'Coconut Chutney', price: 15),
      ],
      thaliOptions: [
        ThaliOption(name: 'South Indian Thali', price: 120),
        ThaliOption(name: 'Combo Thali', price: 150),
      ],
      imageUrl: '',
    ),
    Mess(
      id: '4',
      name: 'Punjabi Dhaba',
      address: '321 Highway Road, City',
      rating: 4.3,
      menuItems: [
        MenuItem(name: 'Rajma', price: 90),
        MenuItem(name: 'Chole', price: 80),
        MenuItem(name: 'Butter Naan', price: 30),
        MenuItem(name: 'Lassi', price: 40),
        MenuItem(name: 'Pickle', price: 10),
      ],
      thaliOptions: [
        ThaliOption(name: 'Punjabi Thali', price: 180),
        ThaliOption(name: 'Special Dhaba Thali', price: 220),
      ],
      imageUrl: '',
    ),
    Mess(
      id: '5',
      name: 'Gujarati Mess',
      address: '654 Traditional Street, City',
      rating: 4.6,
      menuItems: [
        MenuItem(name: 'Dhokla', price: 50),
        MenuItem(name: 'Thepla', price: 30),
        MenuItem(name: 'Khandvi', price: 60),
        MenuItem(name: 'Undhiyu', price: 100),
        MenuItem(name: 'Fafda', price: 40),
      ],
      thaliOptions: [
        ThaliOption(name: 'Gujarati Thali', price: 150),
        ThaliOption(name: 'Snacks Combo', price: 120),
      ],
      imageUrl: '',
    ),
  ];

  Map<String, int> cartItems = {};
  int totalItems = 0;
  double totalAmount = 0;
  final double discount = 20.0;

  void _toggleFavorite(String messId) {
    setState(() {
      messes = messes.map((mess) {
        if (mess.id == messId) {
          return mess.copyWith(isFavorite: !mess.isFavorite);
        }
        return mess;
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
      for (var mess in messes) {
        var thali = mess.thaliOptions.firstWhere(
          (t) => t.name == itemName,
          orElse: () => ThaliOption(name: '', price: 0),
        );
        if (thali.name.isNotEmpty) {
          totalAmount += thali.price * quantity;
          break;
        }
        var menuItem = mess.menuItems.firstWhere(
          (m) => m.name == itemName,
          orElse: () => MenuItem(name: '', price: 0),
        );
        if (menuItem.name.isNotEmpty) {
          totalAmount += menuItem.price * quantity;
          break;
        }
      }
    });
  }

  void _showMenuDialog(Mess mess) {
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
                  mess.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Thali Options',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                ...mess.thaliOptions.map((thali) => MenuItemCard(
                      itemName: thali.name,
                      price: thali.price,
                      quantity: cartItems[thali.name] ?? 0,
                      onIncrement: () {
                        _updateCart(thali.name, (cartItems[thali.name] ?? 0) + 1, thali.price);
                        setModalState(() {});
                      },
                      onDecrement: () {
                        _updateCart(thali.name, (cartItems[thali.name] ?? 0) - 1, thali.price);
                        setModalState(() {});
                      },
                    )),
                SizedBox(height: 16),
                Text(
                  'Additional Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                ...mess.menuItems.map((item) => MenuItemCard(
                      itemName: item.name,
                      price: item.price,
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
        title: Text('Mess List'),
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
                                for (var mess in messes) {
                                  var thali = mess.thaliOptions.firstWhere(
                                    (t) => t.name == entry.key,
                                    orElse: () => ThaliOption(name: '', price: 0),
                                  );
                                  if (thali.name.isNotEmpty) {
                                    itemPrice = thali.price;
                                    break;
                                  }
                                  var menuItem = mess.menuItems.firstWhere(
                                    (m) => m.name == entry.key,
                                    orElse: () => MenuItem(name: '', price: 0),
                                  );
                                  if (menuItem.name.isNotEmpty) {
                                    itemPrice = menuItem.price;
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
        itemCount: messes.length,
        itemBuilder: (context, index) {
          final mess = messes[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: MessCard(
              mess: mess,
              onFavoritePressed: () => _toggleFavorite(mess.id),
              onCardPressed: () => _showMenuDialog(mess),
            ),
          );
        },
      ),
    );
  }
}
