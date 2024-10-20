import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_amazon_clone/features/admin/model/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;
  Product({
    this.rating,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
  });

  Product copyWith({
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? category,
    List<String>? images,
    ValueGetter<String?>? id,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      images: images ?? this.images,
      id: id != null ? id() : this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      '_id': id,
      // 'ratings': rating?.map((rating) => rating.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      category: map['category'] ?? '',
      images: List<String>.from(map['images']),
      id: map['_id'],

      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, description: $description, price: $price, quantity: $quantity, category: $category, images: $images, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.quantity == quantity &&
        other.category == category &&
        listEquals(other.images, images) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        images.hashCode ^
        id.hashCode;
  }
}
