// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomersModel {
  final int? id;
  final String customerName;
  final String phone;
  CustomersModel({
    this.id,
    required this.customerName,
    required this.phone,
  });

  CustomersModel copyWith({
    int? id,
    String? customerName,
    String? phone,
  }) {
    return CustomersModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CustomerName': customerName,
      'Phone': phone,
    };
  }

  factory CustomersModel.fromMap(Map<String, dynamic> map) {
    return CustomersModel(
      id: map['id'] != null ? map['id'] as int : null,
      customerName: map['CustomerName'] as String,
      phone: map['Phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersModel.fromJson(String source) =>
      CustomersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CustomersModel(id: $id, CustomerName: $customerName, Phone: $phone)';

  @override
  bool operator ==(covariant CustomersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerName == customerName &&
        other.phone == phone;
  }

  @override
  int get hashCode => id.hashCode ^ customerName.hashCode ^ phone.hashCode;
}
