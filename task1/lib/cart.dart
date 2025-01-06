import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/provider/cart_provider.dart';
import 'package:task1/drinkmenu.dart';
import 'package:task1/Models/posts_model.dart';

class MyCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<
        Cart>(); //This allows real-time updates to the UI when the cart's state changes

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
                return ListTile(
                  tileColor: Color(0xFFCAC6C6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(Dmenu[index].image.toString(),
                      height: 100, width: 60),
                  title: Text(
                    cart.items[index].name.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      cart.removeItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(" removed from cart!"),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // SnackBar in Flutter is a lightweight message or notification that briefly appears at the bottom of the screen.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Proceeding to checkout..."),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: Text('Checkout'),
        ),
      ),
    );
  }
}
