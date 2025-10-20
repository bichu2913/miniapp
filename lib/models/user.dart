import 'package:hive/hive.dart';


part 'user.g.dart';


@HiveType(typeId: 0)
class User extends HiveObject {
@HiveField(0)
final int id;


@HiveField(1)
final String email;


@HiveField(2)
final String name;


@HiveField(3)
final String? token;


User({required this.id, required this.email, required this.name, this.token});


factory User.fromJson(Map<String, dynamic> json, {String? token}) {
return User(
id: json['id'] as int,
email: json['email'] as String? ?? '',
name: json['name'] as String? ?? '',
token: token,
);
}


Map<String, dynamic> toJson() => {
'id': id,
'email': email,
'name': name,
'token': token,
};
}