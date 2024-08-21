// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAppModel {
  final String access_token;
  UserAppModel({
    required this.access_token,
  });

  UserAppModel copyWith({
    String? access_token,
  }) {
    return UserAppModel(
      access_token: access_token ?? this.access_token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': access_token,
    };
  }

  factory UserAppModel.fromMap(Map<String, dynamic> map) {
    return UserAppModel(
      access_token: map['access_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAppModel.fromJson(String source) =>
      UserAppModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserAppModel(access_token: $access_token)';

  @override
  bool operator ==(covariant UserAppModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.access_token == access_token;
  }

  @override
  int get hashCode => access_token.hashCode;
}
