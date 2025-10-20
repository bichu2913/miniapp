import 'package:hive/hive.dart';
import 'product.dart';


part 'cart_item.g.dart';


@HiveType(typeId: 3)
class CartItem extends HiveObject {
@HiveField(0)
final Product product;


@HiveField(1)
int quantity;


CartItem({required this.product, required this.quantity});


double get total => product.price * quantity;
}