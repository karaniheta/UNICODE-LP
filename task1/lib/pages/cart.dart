import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task1/provider/cart_provider.dart';

class MyCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: ListTile(
                    tileColor: Color.fromRGBO(207, 207, 207, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.network(item.image.toString(),
                        height: 150, width: 100),
                    title: Text(
                      item.name.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: cart.items.isEmpty ? null : () => _checkout(context, cart),
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
        'items': cart.items.map((item) => item.name).toList(),
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
