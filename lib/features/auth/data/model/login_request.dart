// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequest {
  final String fname;
  final String password;
  LoginRequest({
    required this.fname,
    required this.password,
  });

  LoginRequest copyWith({
    String? username,
    String? password,
  }) {
    return LoginRequest(
      fname: username ?? fname,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fname': fname,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      fname: map['fname'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginRequest(fname: $fname, password: $password)';

  @override
  bool operator ==(covariant LoginRequest other) {
    if (identical(this, other)) return true;

    return other.fname == fname && other.password == password;
  }

  @override
  int get hashCode => fname.hashCode ^ password.hashCode;
}
