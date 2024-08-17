// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomersModel {
  final int id;
  final String customerName;
  final String photo;
  CustomersModel({
    required this.id,
    required this.customerName,
    required this.photo,
  });
  

  CustomersModel copyWith({
    int? id,
    String? customerName,
    String? photo,
  }) {
    return CustomersModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerName': customerName,
      'photo': photo,
    };
  }

  factory CustomersModel.fromMap(Map<String, dynamic> map) {
    return CustomersModel(
      id: map['id'] as int,
      customerName: map['customerName'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersModel.fromJson(String source) => CustomersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Customers(id: $id, customerName: $customerName, photo: $photo)';

  @override
  bool operator ==(covariant CustomersModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.customerName == customerName &&
      other.photo == photo;
  }

  @override
  int get hashCode => id.hashCode ^ customerName.hashCode ^ photo.hashCode;
}
