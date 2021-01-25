import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

/// A phone number
///
/// | Field              | Android | iOS |
/// |--------------------|:-------:|:---:|
/// | number             | ✔       | ✔   |
/// | normalizedNumber   | ✔       | ⨯   |
/// | label              | ✔       | ✔   |
/// | customLabel        | ✔       | ✔   |
/// | isPrimary          | ✔       | ⨯   |
@JsonSerializable(disallowUnrecognizedKeys: true)
class Phone {
  /// Phone number.
  @JsonKey(required: true)
  String number;

  /// Normalized phone number (android only).
  ///
  /// Android sometimes computes a normalized number, e.g. +12345678900 for
  /// +1 (234) 567-8900
  @JsonKey(defaultValue: "")
  String normalizedNumber;

  /// The label or type of phone it is. If `custom`, the free-form label can be
  /// found in [customLabel].
  @JsonKey(defaultValue: PhoneLabel.mobile)
  PhoneLabel label;

  /// If [customLabel] is [PhoneLabel.custom], free-form user-chosen label.
  @JsonKey(defaultValue: "")
  String customLabel;

  /// Android has a notion of primary phone, so that "call X" means call X's
  /// primary phone number, in case there are multiple. Android only.
  @JsonKey(defaultValue: false)
  bool isPrimary;

  Phone(this.number,
      {this.label = PhoneLabel.mobile,
      this.normalizedNumber = "",
      this.customLabel = "",
      this.isPrimary = false});

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}

/// Phone labels
///
/// | Label       | Android | iOS |
/// |-------------|:-------:|:---:|
/// | assistant   | ✔       | ⨯   |
/// | callback    | ✔       | ⨯   |
/// | car         | ✔       | ⨯   |
/// | companyMain | ✔       | ⨯   |
/// | faxHome     | ✔       | ✔   |
/// | faxOther    | ✔       | ✔   |
/// | faxWork     | ✔       | ✔   |
/// | home        | ✔       | ✔   |
/// | iPhone      | ⨯       | ✔   |
/// | isdn        | ✔       | ⨯   |
/// | main        | ✔       | ✔   |
/// | mms         | ✔       | ⨯   |
/// | mobile      | ✔       | ✔   |
/// | pager       | ✔       | ✔   |
/// | radio       | ✔       | ⨯   |
/// | school      | ⨯       | ✔   |
/// | telex       | ✔       | ⨯   |
/// | ttyTtd      | ✔       | ⨯   |
/// | work        | ✔       | ✔   |
/// | workMobile  | ✔       | ⨯   |
/// | workPager   | ✔       | ⨯   |
/// | other       | ✔       | ✔   |
/// | custom      | ✔       | ✔   |
enum PhoneLabel {
  assistant,
  callback,
  car,
  companyMain,
  faxHome,
  faxOther,
  faxWork,
  home,
  iPhone,
  isdn,
  main,
  mms,
  mobile,
  pager,
  radio,
  school,
  telex,
  ttyTtd,
  work,
  workMobile,
  workPager,
  other,
  custom,
}
