// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  final int id;
  final String customerName;
  final String phone;
  Customer({
    required this.id,
    required this.customerName,
    required this.phone,
  });

  Customer copyWith({
    int? id,
    String? customerName,
    String? phone,
  }) {
    return Customer(
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

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      customerName: map['CustomerName'] as String,
      phone: map['Phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Customer(id: $id, customerName: $customerName, phone: $phone)';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerName == customerName &&
        other.phone == phone;
  }

  @override
  int get hashCode => id.hashCode ^ customerName.hashCode ^ phone.hashCode;
}
