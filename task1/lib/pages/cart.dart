import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task1/pages/homepage.dart';
import 'package:task1/provider/cart_provider.dart';
import '../Models/posts_model.dart';

class MyCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Scaffold(
      backgroundColor: Color(0xFFF8E3B6),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF834D1E),
          ),
        ),
        title: Text(
          'Your Cart',
          style: TextStyle(color: Color(0xFF834D1E)),
        ),
        backgroundColor: Color(0xFFF8E3B6),
      ),
      body: Column(
        children: [
          if (cart.items.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Your cart is empty!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) {
                  final cartItem = cart.items[index];
                  final item = cartItem['item'] as PostsModel;
                  final quantity = cartItem['quantity'] as int;

                  return Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
                    child: ListTile(
                      tileColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFF834D1E), width: 2),
                      ),
                      contentPadding: EdgeInsets.all(5),
                      leading: Image.network(
                        item.image.toString(),
                        height: 150,
                        width: 100,
                      ),
                      title: Text(
                        item.name.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Color(0xFF834D1E)),
                            onPressed: () {
                              cart.decreaseQuantity(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Quantity decreased!"),
                                ),
                              );
                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Color(0xFF834D1E)),
                            onPressed: () {
                              cart.increaseQuantity(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Quantity increased!"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Color(0xFF834D1E)),
                        onPressed: () {
                          cart.removeItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Removed from cart!"),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\Rs.${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF834D1E),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFF8E3B6),
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed:
                  cart.items.isEmpty ? null : () => _checkout(context, cart),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF834D1E),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkout(BuildContext context, Cart cart) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Cafe')
          .doc(user.uid)
          .collection('Orders')
          .add({
        'items': cart.items
            .map((cartItem) => {
                  'name': cartItem['item'].name,
                  'quantity': cartItem['quantity']
                })
            .toList(),
        'orderDate': FieldValue.serverTimestamp(),
      });

      // Clear the cart after checkout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order placed successfully!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You need to log in to place an order."),
        ),
      );
    }
  }
}
