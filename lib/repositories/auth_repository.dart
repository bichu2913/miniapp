import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';
import '../services/api_service.dart';


class AuthRepository {
final Box _box;


AuthRepository(this._box);


Future<User> login(String email, String password) async {
final api = ApiService();
final resp = await api.client.post('/api/v1/auth/login', data: {'email': email, 'password': password});
final token = resp.data['access_token'] as String?;
// fetch profile
final apiAuth = ApiService(token: token);
final profileResp = await apiAuth.client.get('/api/v1/auth/profile');
final user = User.fromJson(profileResp.data, token: token);
await _box.put('user', user);
return user;
}


User? getLocalUser() {
return _box.get('user') as User?;
}


Future<void> logout() async {
await _box.delete('user');
}
}