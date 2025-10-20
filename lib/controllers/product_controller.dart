import 'package:get/get.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';





class ProductController extends GetxController {
final ProductRepository repo;
final RxList<Product> products = <Product>[].obs;
final RxBool loading = false.obs;


ProductController(this.repo);


Future<void> load() async {
loading.value = true;
final list = await repo.fetchProducts();
products.assignAll(list);
loading.value = false;
}


List<Product> byCategory(int categoryId) => products.where((p) => p.categoryId == categoryId).toList();
}


