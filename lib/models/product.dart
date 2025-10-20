import 'package:hive/hive.dart';


part 'product.g.dart';


@HiveType(typeId: 2)
class Product extends HiveObject {
@HiveField(0)
final int id;


@HiveField(1)
final String title;


@HiveField(2)
final String description;


@HiveField(3)
final double price;


@HiveField(4)
final List<String> images;


@HiveField(5)
final int categoryId;


Product({required this.id, required this.title, required this.description, required this.price, required this.images, required this.categoryId});


factory Product.fromJson(Map<String, dynamic> json) => Product(
id: json['id'] as int,
title: json['title'] ?? '',
description: json['description'] ?? '',
price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as double? ?? 0.0),
images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
categoryId: (json['category'] is Map) ? (json['category']['id'] as int) : (json['category'] as int? ?? 0),
);
}