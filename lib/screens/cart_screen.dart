import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.cartItems.isEmpty
                ? Center(
                    child: Text(
                      "Seu carrinho está vazio",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cart.cartItems[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: ListTile(
                          leading: product.image.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: AssetImage(product.image),
                                  radius: 24,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.deepPurple.shade100,
                                  child: Text(
                                    product.name[0],
                                    style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                  ),
                                ),
                          title: Text(
                            product.name,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.redAccent),
                            onPressed: () {
                              cart.removeProduct(product);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  "Total: R\$ ${cart.total.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cart.cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PaymentScreen()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Finalizar Compra",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
