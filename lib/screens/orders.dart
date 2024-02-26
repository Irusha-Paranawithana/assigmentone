import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseItemsPage extends StatefulWidget {
  @override
  _FirebaseItemsPageState createState() => _FirebaseItemsPageState();
}

class _FirebaseItemsPageState extends State<FirebaseItemsPage> {
  late CollectionReference _ordersCollection;
  List<DocumentSnapshot> _orders = [];

  @override
  void initState() {
    super.initState();
    // Initialize the CollectionReference
    _ordersCollection = FirebaseFirestore.instance.collection('orders');
    // Listen for changes in the collection
    _ordersCollection.snapshots().listen((snapshot) {
      setState(() {
        _orders = snapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Orders'),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index].data() as Map<String, dynamic>;
          return ListTile(
            leading: Image.network(
              order['img'],
              width: 50,
              height: 50,
            ),
            title: Text(order['name']),
            subtitle: Text('Price: \$${order['price']}'),
          );
        },
      ),
    );
  }
}
