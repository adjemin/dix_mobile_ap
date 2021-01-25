// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvoicePayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicePayment _$InvoicePaymentFromJson(Map<String, dynamic> json) {
  return InvoicePayment(
    id: json['id'] as int,
    invoice_id: json['invoice_id'] as int,
    payment_reference: json['payment_reference'] as String,
    amount: json['amount'] as String,
    currency_code: json['currency_code'] as String,
    currency_name: json['currency_name'] as String,
  );
}

Map<String, dynamic> _$InvoicePaymentToJson(InvoicePayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoice_id,
      'payment_reference': instance.payment_reference,
      'amount': instance.amount,
      'currency_code': instance.currency_code,
      'currency_name': instance.currency_name,
    };
