import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/cart_item.dart';
import '../models/product.dart';




class CartController extends GetxController {
final Box<CartItem> box;
final RxList<CartItem> items = <CartItem>[].obs;


CartController(this.box);


@override
void onInit() {
super.onInit();
final list = box.values.toList();
items.assignAll(list);
}


void addProduct(Product product) {
final existing = items.firstWhereOrNull((c) => c.product.id == product.id);
if (existing != null) {
existing.quantity += 1;
existing.save();
} else {
final cartItem = CartItem(product: product, quantity: 1);
box.add(cartItem);
items.add(cartItem);
}
}


void removeItem(CartItem item) {
item.delete();
items.remove(item);
}


void changeQuantity(CartItem item, int quantity) {
if (quantity <= 0) {
removeItem(item);
return;
}
item.quantity = quantity;
item.save();
items.refresh();
}


double get total => items.fold(0.0, (s, e) => s + e.total);
}