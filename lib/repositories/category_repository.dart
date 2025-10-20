import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../models/category.dart';
import '../services/api_service.dart';



class CategoryRepository {
  final Box _box;
  final ApiService apiService;

  CategoryRepository(this._box, this.apiService);

  Future<List<Category>> fetchCategories() async {
    try {
      final resp = await apiService.client.get('/api/v1/categories');
      final list = (resp.data as List)
          .map((e) => Category.fromJson(e))
          .toList();

      // ✅ Store the whole list under a single key
      await _box.put('categories', list);
      print("✅ Categories fetched and cached: ${list.length}");
      return list;
    } on DioError catch (e) {
      print("⚠️ Failed to fetch categories: $e");
      final cached = _box.get('categories');
      if (cached is List) {
        return cached.cast<Category>();
      }
      return [];
      
    }
  }

  List<Category> getCached() {
    final cached = _box.get('categories');
    if (cached is List) return cached.cast<Category>();
    return [];
  }
}



