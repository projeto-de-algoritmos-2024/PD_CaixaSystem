import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: 1, name: 'Coca-Cola', price: 5.00, image: 'assets/images/coca_cola.png'),
    Product(id: 2, name: 'Pão', price: 2.50, image: 'assets/images/pao.jpg'),
    Product(id: 3, name: 'Queijo', price: 10.00, image: 'assets/images/queijo.jpeg'),
    Product(id: 4, name: 'Arroz', price: 20.00, image: 'assets/images/arroz.jpg'),
    Product(id: 5, name: 'Feijão', price: 8.00, image: 'assets/images/feijao.jpg'),
    Product(id: 6, name: 'Leite', price: 4.50, image: 'assets/images/leite.png'),
    Product(id: 7, name: 'Macarrão', price: 7.00, image: 'assets/images/macarrao.png'),
    Product(id: 8, name: 'Café', price: 15.00, image: 'assets/images/cafe.png'),
    Product(id: 9, name: 'Chocolate', price: 12.00, image: 'assets/images/chocolate.png'),
    Product(id: 10, name: 'Manteiga', price: 9.50, image: 'assets/images/manteiga.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(product.image, fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false).addProduct(product);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        child: Text("Adicionar", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
