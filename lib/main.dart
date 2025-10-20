import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/cart_item.dart';
import 'models/category.dart';
import 'models/product.dart';
import 'models/user.dart';
import 'repositories/auth_repository.dart';
import 'repositories/category_repository.dart';
import 'repositories/product_repository.dart';

import 'controllers/auth_controller.dart';
import 'controllers/category_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/cart_controller.dart';

import 'services/api_service.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';
import 'views/cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartItemAdapter());

  final box = await Hive.openBox('app_box');
  final cartBox = await Hive.openBox<CartItem>('cart_box');
  final categoryBox = await Hive.openBox('categoryBox');
  final productBox = await Hive.openBox('products');


  final user = box.get('user') as User?;
  final api = ApiService(token: user?.token);

  final categoryRepo = CategoryRepository(categoryBox, api);
  final productRepo = ProductRepository(productBox, api);

  // Controllers
  final categoryC = Get.put(CategoryController(categoryRepo));
  final productC = Get.put(ProductController(productRepo));
  Get.put(CartController(cartBox));

 
    await categoryC.load();
    await productC.load();
  

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return GetMaterialApp(
      title: 'Mini Shop',
      initialRoute: auth.isLoggedIn ? '/home' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/cart', page: () => CartPage()),
      ],
    );
  }
}
