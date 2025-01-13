import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PastOrdersPage extends StatefulWidget {
  @override
  _PastOrdersPageState createState() => _PastOrdersPageState();
}

class _PastOrdersPageState extends State<PastOrdersPage> {
  List<Map<String, dynamic>> pastOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPastOrders();
  }

  Future<void> _fetchPastOrders() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Cafe')
          .doc(user.uid)
          .collection('Orders')
          .orderBy('orderDate', descending: true)
          .get();

      setState(() {
        pastOrders = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Orders'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pastOrders.isEmpty
              ? Center(
                  child: Text(
                    'No past orders found!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: pastOrders.length,
                  itemBuilder: (context, index) {
                    final order = pastOrders[index];
                    final orderDate =
                        (order['orderDate'] as Timestamp).toDate();

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          'Order #${index + 1}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Items: ${order['items'].join(', ')}'),
                            Text(
                              'Order Date: ${orderDate.toLocal()}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
