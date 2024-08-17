// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HawalaModel {
  final int id;
  final String name;
  final String type;
  final String currency;
  final String allPaid;
  final DateTime postingDate;
  final String customerName;
  final String amount;
  final String partial;
  final String paidAtOnce;
  HawalaModel({
    required this.id,
    required this.name,
    required this.type,
    required this.currency,
    required this.allPaid,
    required this.postingDate,
    required this.customerName,
    required this.amount,
    required this.partial,
    required this.paidAtOnce,
  });

  HawalaModel copyWith({
    int? id,
    String? name,
    String? type,
    String? currency,
    String? allPaid,
    DateTime? postingDate,
    String? customerName,
    String? amount,
    String? partial,
    String? paidAtOnce,
  }) {
    return HawalaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      currency: currency ?? this.currency,
      allPaid: allPaid ?? this.allPaid,
      postingDate: postingDate ?? this.postingDate,
      customerName: customerName ?? this.customerName,
      amount: amount ?? this.amount,
      partial: partial ?? this.partial,
      paidAtOnce: paidAtOnce ?? this.paidAtOnce,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'currency': currency,
      'allPaid': allPaid,
      'postingDate': postingDate.millisecondsSinceEpoch,
      'customerName': customerName,
      'amount': amount,
      'partial': partial,
      'paidAtOnce': paidAtOnce,
    };
  }

  factory HawalaModel.fromMap(Map<String, dynamic> map) {
    return HawalaModel(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      currency: map['currency'] as String,
      allPaid: map['allPaid'] as String,
      postingDate: DateTime.fromMillisecondsSinceEpoch(map['postingDate'] as int),
      customerName: map['customerName'] as String,
      amount: map['amount'] as String,
      partial: map['partial'] as String,
      paidAtOnce: map['paidAtOnce'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HawalaModel.fromJson(String source) =>
      HawalaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hawala(id: $id, name: $name, type: $type, currency: $currency, allPaid: $allPaid, postingDate: $postingDate, customerName: $customerName, amount: $amount, partial: $partial, paidAtOnce: $paidAtOnce)';
  }

  @override
  bool operator ==(covariant HawalaModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.type == type &&
      other.currency == currency &&
      other.allPaid == allPaid &&
      other.postingDate == postingDate &&
      other.customerName == customerName &&
      other.amount == amount &&
      other.partial == partial &&
      other.paidAtOnce == paidAtOnce;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      type.hashCode ^
      currency.hashCode ^
      allPaid.hashCode ^
      postingDate.hashCode ^
      customerName.hashCode ^
      amount.hashCode ^
      partial.hashCode ^
      paidAtOnce.hashCode;
  }
}
