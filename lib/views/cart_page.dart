import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';


class CartPage extends StatelessWidget {
final CartController cartC = Get.find();


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Cart')),
body: Obx(() {
if (cartC.items.isEmpty) return const Center(child: Text('Cart is empty'));
return Column(
children: [
Expanded(
child: ListView.builder(
itemCount: cartC.items.length,
itemBuilder: (_, i) {
final item = cartC.items[i];
return ListTile(
leading: item.product.images.isNotEmpty ? Image.network(item.product.images.first, width: 56, height: 56, fit: BoxFit.cover) : null,
title: Text(item.product.title),
subtitle: Text('\$${item.product.price} x ${item.quantity} = \$${item.total.toStringAsFixed(2)}'),
trailing: Row(mainAxisSize: MainAxisSize.min, children: [
IconButton(icon: const Icon(Icons.remove), onPressed: () => cartC.changeQuantity(item, item.quantity - 1)),
IconButton(icon: const Icon(Icons.add), onPressed: () => cartC.changeQuantity(item, item.quantity + 1)),
]),
);
},
),
),
Padding(
padding: const EdgeInsets.all(12.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text('Total: \$${cartC.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
ElevatedButton(onPressed: () => Get.snackbar('Checkout', 'Local-only demo. No API call.'), child: const Text('Checkout'))
],
),
)
],
);
}),
);
}
}