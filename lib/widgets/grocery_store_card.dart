import 'package:flutter/material.dart';
import '../models/grocery_store.dart';

class GroceryStoreCard extends StatelessWidget {
  final GroceryStore store;
  final VoidCallback onFavoritePressed;
  final VoidCallback onCardPressed;

  const GroceryStoreCard({
    Key? key,
    required this.store,
    required this.onFavoritePressed,
    required this.onCardPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onCardPressed,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.store,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      store.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: store.isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    store.address,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        store.rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 