import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_amazon_clone/features/admin/model/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  Order( {
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.totalPrice,
    required this.orderedAt,
    required this.status,
  });

  Order copyWith({
    String? id,
    List<Product>? products,
    List<int>? quantity,
    String? address,
    String? userId,
    int? orderedAt,
    int? status,
    double? totalPrice,
  }) {
    return Order(
      id: id ?? this.id,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice' : totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, products: $products, quantity: $quantity, address: $address, userId: $userId, orderAt: $orderedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        listEquals(other.products, products) &&
        listEquals(other.quantity, quantity) &&
        other.address == address &&
        other.userId == userId &&
        other.orderedAt == orderedAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        products.hashCode ^
        quantity.hashCode ^
        address.hashCode ^
        userId.hashCode ^
        orderedAt.hashCode ^
        status.hashCode;
  }
}
