import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/category.dart';
import '../repositories/category_repository.dart';




class CategoryController extends GetxController {
final CategoryRepository repo;
final RxList<Category> categories = <Category>[].obs;
final RxBool loading = false.obs;


CategoryController(this.repo);


Future<void> load() async {
loading.value = true;
final list = await repo.fetchCategories();
categories.assignAll(list);
loading.value = false;
}
}