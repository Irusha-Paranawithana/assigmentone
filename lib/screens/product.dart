import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemImgUrl;

  ProductDescriptionPage({
    required this.itemName,
    required this.itemPrice,
    required this.itemImgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Description'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(itemImgUrl),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    itemPrice,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Define the data to be added to Firestore for the order
                      Map<String, dynamic> orderData = {
                        'name': itemName,
                        'price': itemPrice,
                        'img': itemImgUrl,
                        // You can add additional fields such as quantity, user ID, etc.
                      };

                      // Add data to the Firestore collection for orders
                      FirebaseFirestore.instance
                          .collection('orders')
                          .add(orderData)
                          .then((value) {
                        print('Order placed successfully!');
                      }).catchError((error) {
                        print('Failed to place order: $error');
                      });
                    },
                    child: Text('Buy Now'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Define the data to be added to Firestore
                      Map<String, dynamic> cartData = {
                        'name': itemName,
                        'price': itemPrice,
                        'img': itemImgUrl,
                      };

                      // Add data to the Firestore collection
                      FirebaseFirestore.instance
                          .collection('cart')
                          .add(cartData)
                          .then((value) {
                        print('Item added to cart successfully!');
                      }).catchError((error) {
                        print('Failed to add item to cart: $error');
                      });
                    },
                    child: Text('Add To Cart'),
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
