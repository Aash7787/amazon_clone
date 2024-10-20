import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String address;
  final String type;
  final String token;
  final String email;
  final List<dynamic> cart;
  User({
    required this.cart,
    required this.id,
    required this.name,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.email,
  });

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? address,
    String? type,
    String? token,
    String? email,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      email: email ?? this.email,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'email': email,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      email: map['email'] ?? '',
      //  cart: [],
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, password: $password, address: $address, type: $type, token: $token, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.password == password &&
        other.address == address &&
        other.type == type &&
        other.token == token &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        password.hashCode ^
        address.hashCode ^
        type.hashCode ^
        token.hashCode ^
        email.hashCode;
  }
}
