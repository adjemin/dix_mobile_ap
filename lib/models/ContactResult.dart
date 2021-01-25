import 'dart:convert';

import 'package:dixapp/util/dixcontact.dart';

import 'package:json_annotation/json_annotation.dart';

part 'ContactResult.g.dart';

@JsonSerializable()
class ContactResult {

  final List<DixContact> contacts;
  final int totalContactCount;
  final int moovContactCount;
  final int mtnContactCount;
  final int orangeContactCount;
  final int totalNumberCount;
  final int totalConvertedNumberCount;
  final int totalNoneConvertedNumberCount;

  const ContactResult({
    this.contacts, this.totalContactCount, this.moovContactCount,
    this.mtnContactCount, this.orangeContactCount, this.totalNumberCount,
    this.totalConvertedNumberCount,
    this.totalNoneConvertedNumberCount
  });

  factory ContactResult.fromJson(Map<String, dynamic> json) => _$ContactResultFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResultToJson(this);

  String toJsonString(){
    return jsonEncode(toJson());
  }
  
  
}