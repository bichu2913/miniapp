import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../repositories/auth_repository.dart';
import '../models/user.dart';


class AuthController extends GetxController {
final AuthRepository _repo;
final Rxn<User> user = Rxn<User>();


AuthController(this._repo);


@override
void onInit() {
super.onInit();
user.value = _repo.getLocalUser();
}


bool get isLoggedIn => user.value != null;


Future<void> login(String email, String password) async {
final u = await _repo.login(email, password);
user.value = u;
}


Future<void> logout() async {
await _repo.logout();
user.value = null;
}
}