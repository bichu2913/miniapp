import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../utils/responsive.dart';
import 'product_tile.dart';

class HomePage extends StatelessWidget {
  final CategoryController catC = Get.find();
  final ProductController prodC = Get.find();
  final CartController cartC = Get.find();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final type = deviceType(mq);
    final crossAxis =
        (type == DeviceType.phone) ? (mq.size.width > 600 ? 3 : 2) : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed('/cart'),
          )
        ],
      ),
      drawer: Drawer(
        child: Obx(() {
          if (catC.loading.value)
            return const Center(child: CircularProgressIndicator());
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(child: Text('Categories')),
              ...catC.categories.map((c) => ListTile(
                    title: Text(c.name),
                    onTap: () {
                      Get.back();
                      final list = prodC.byCategory(c.id);

                      Get.to(() => Scaffold(
                            appBar: AppBar(title: Text(c.name)),
                            body: GridView.builder(
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxis,
                                      childAspectRatio: 0.7),
                              itemCount: list.length,
                              itemBuilder: (_, i) => ProductTile(
                                  product: list[i],
                                  onAdd: () => cartC.addProduct(list[i])),
                            ),
                          ));
                    },
                  ))
            ],
          );
        }),
      ),
      body: Obx(() {
        if (prodC.loading.value)
          return const Center(child: CircularProgressIndicator());
        final products = prodC.products;
        return OrientationBuilder(builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;
          final columns = isLandscape ? crossAxis + 1 : crossAxis;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns, childAspectRatio: 0.7),
            itemCount: products.length,
            itemBuilder: (_, i) => ProductTile(
                product: products[i],
                onAdd: () => cartC.addProduct(products[i])),
          );
        });
      }),
    );
  }
}
