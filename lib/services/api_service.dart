import 'package:dio/dio.dart';
import '../constants/env.dart';


class ApiService {
late final Dio _dio;


ApiService({String? token}) {
_dio = Dio(BaseOptions(baseUrl: Env.baseUrl, connectTimeout: Duration(seconds: 10)))
..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
if (token != null && token.isNotEmpty) {
options.headers['Authorization'] = 'Bearer $token';
}
return handler.next(options);
}));
}


Dio get client => _dio;
}