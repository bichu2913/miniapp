import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';
import '../services/api_service.dart';



class ProductRepository {
  final Box _box;
  final ApiService apiService;

  ProductRepository(this._box, this.apiService);

  Future<List<Product>> fetchProducts({int offset = 0, int limit = 50}) async {
    try {
      final resp = await apiService.client.get(
        '/api/v1/products',
        queryParameters: {'offset': offset, 'limit': limit},
      );
      final list = (resp.data as List)
          .map((e) => Product.fromJson(e))
          .toList();

      
      await _box.put('products', list);
      return list;
    } on DioError {
      
      final cached = _box.get('products');
      if (cached is List) {
        return cached.cast<Product>();
      }
      return [];
    }
  }

  List<Product> getCached() {
    final cached = _box.get('products');
    if (cached is List) {
      return cached.cast<Product>();
    }
    return [];
  }
}
