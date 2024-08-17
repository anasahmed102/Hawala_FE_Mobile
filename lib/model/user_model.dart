// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAppModel {
  final String token;
  UserAppModel({
    required this.token,
  });

  UserAppModel copyWith({
    String? token,
  }) {
    return UserAppModel(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory UserAppModel.fromMap(Map<String, dynamic> map) {
    return UserAppModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAppModel.fromJson(String source) =>
      UserAppModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserAppModel(token: $token)';

  @override
  bool operator ==(covariant UserAppModel other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
