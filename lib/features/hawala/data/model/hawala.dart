// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hawala/features/hawala/data/model/hawala_customer.dart';

class HawalaModel {
  final int? id;
  final int customerId;
  final Customer? customer;
  final int type;
  final int currency;
  final bool fullPaid;
  final String postingDate;
  final int paidAmount;
  final int totalAmount;

  HawalaModel({
     this.id,
    required this.customerId,
     this.customer,
    required this.type,
    required this.currency,
    required this.fullPaid,
    required this.postingDate,
    required this.paidAmount,
    required this.totalAmount,
  });

  HawalaModel copyWith({
    int? id,
    Customer? customer,
    int? customerId,
    int? type,
    int? currency,
    bool? fullPaid,
    String? postingDate,
    int? paidAmount,
    int? totalAmount,
  }) {
    return HawalaModel(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      type: type ?? this.type,
      customerId: customerId ?? this.customerId,
      currency: currency ?? this.currency,
      fullPaid: fullPaid ?? this.fullPaid,
      postingDate: postingDate ?? this.postingDate,
      paidAmount: paidAmount ?? this.paidAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Customer': customer!.toMap(),
      'Type': type,
      'Currency': currency,
      'FullPaid': fullPaid,
      'PostingDate': postingDate,
      'PaidAmount': paidAmount,
      'TotalAmount': totalAmount,
      'customerId': customerId
    };
  }

  factory HawalaModel.fromMap(Map<String, dynamic> map) {
    return HawalaModel(
      id: map['id'] as int,
      customerId: map['customerId'] as int,
      customer: Customer.fromMap(map['Customer'] as Map<String, dynamic>),
      type: map['Type'] as int,
      currency: map['Currency'] as int,
      fullPaid: map['FullPaid'] as bool,
      postingDate: (map['PostingDate'] as String),
      paidAmount: map['PaidAmount'] as int,
      totalAmount: map['TotalAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HawalaModel.fromJson(String source) =>
      HawalaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HawalaModel(id: $id, customer: $customer, type: $type, currency: $currency, fullPaid: $fullPaid, postingDate: $postingDate, paidAmount: $paidAmount, totalAmount: $totalAmount, customerId: $customerId)';
  }

  @override
  bool operator ==(covariant HawalaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customer == customer &&
        other.type == type &&
        other.currency == currency &&
        other.fullPaid == fullPaid &&
        other.postingDate == postingDate &&
        other.paidAmount == paidAmount &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer.hashCode ^
        type.hashCode ^
        currency.hashCode ^
        fullPaid.hashCode ^
        postingDate.hashCode ^
        paidAmount.hashCode ^
        totalAmount.hashCode;
  }
}
