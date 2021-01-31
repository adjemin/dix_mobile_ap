import 'dart:convert';

import 'package:dixapp/util/dixcontact.dart';

import 'package:json_annotation/json_annotation.dart';

part 'BackupResult.g.dart';

@JsonSerializable()
class BackupResult {

  final List<DixContact> backup;

  const BackupResult({
    this.backup,
  });

  factory BackupResult.fromJson(Map<String, dynamic> json) => _$BackupResultFromJson(json);

  Map<String, dynamic> toJson() => _$BackupResultToJson(this);

  String toJsonString(){
    return jsonEncode(toJson());
  }
  
  
}