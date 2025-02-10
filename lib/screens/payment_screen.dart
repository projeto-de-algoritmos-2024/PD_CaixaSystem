import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _controller = TextEditingController();
  String _trocoResultado = "";

  Map<double, int> calcularTroco(double troco, List<double> cedulas) {
    Map<double, int> resultado = {};
    for (var cedula in cedulas) {
      int qtd = (troco ~/ cedula);
      if (qtd > 0) {
        resultado[cedula] = qtd;
        troco -= qtd * cedula;
        troco = double.parse(troco.toStringAsFixed(2)); // Evitar imprecisão
      }
    }
    return resultado;
  }

  void calcular() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    double recebido = double.tryParse(_controller.text) ?? 0;
    double troco = recebido - cart.total;

    if (troco < 0) {
      setState(() {
        _trocoResultado = "Valor insuficiente!";
      });
      return;
    }

    List<double> cedulas = [100, 50, 20, 10, 5, 2, 1, 0.50, 0.25, 0.10, 0.05];
    var resultado = calcularTroco(troco, cedulas);

    setState(() {
      _trocoResultado = "Troco: R\$ ${troco.toStringAsFixed(2)}\n";
      resultado.forEach((cedula, qtd) {
        _trocoResultado += "$qtd x R\$ ${cedula.toStringAsFixed(2)}\n";
      });
    });

    cart.clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Digite o valor recebido:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "R\$ ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.deepPurple.shade50,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calcular,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  "Calcular Troco",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                _trocoResultado,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}