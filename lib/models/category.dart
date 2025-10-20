import 'package:hive/hive.dart';


part 'category.g.dart';


@HiveType(typeId: 1)
class Category extends HiveObject {
@HiveField(0)
final int id;


@HiveField(1)
final String name;


@HiveField(2)
final String? image;


Category({required this.id, required this.name, this.image});


factory Category.fromJson(Map<String, dynamic> json) =>
Category(id: json['id'] as int, name: json['name'] ?? '', image: json['image'] as String?);
}