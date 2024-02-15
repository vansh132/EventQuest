import 'dart:convert';

class User {
  final String id;
  final String username;
  final String password;
  final String type;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.type});
  // final String token;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'type': type});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
