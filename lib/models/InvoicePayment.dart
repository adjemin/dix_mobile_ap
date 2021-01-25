import 'package:json_annotation/json_annotation.dart';

part 'InvoicePayment.g.dart';

@JsonSerializable()
class InvoicePayment{

  final int id;
  final int invoice_id;
  final String payment_reference;
  final String amount;
  final String currency_code;
  final String currency_name;

  const InvoicePayment({this.id, this.invoice_id, this.payment_reference, this.amount,
    this.currency_code, this.currency_name});

  factory InvoicePayment.fromJson(Map<String, dynamic> json) => _$InvoicePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$InvoicePaymentToJson(this);
}