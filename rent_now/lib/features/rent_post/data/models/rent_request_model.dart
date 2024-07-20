// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RentRequestModel {
  //  {
  //               "id": 1,
  //               "rent_type": "one_week",
  //               "pay_per_duration": 1000.0
  //           },

  // ONE_DAY = "one_day", "One Day"
  // ONE_WEEK = "one_week", "One Week"
  // ONE_MONTH = "one_month", "One Month"
  // ONE_YEAR = "one_year", "One Year"
  // DIRECT_BUY = "direct_buy", "Direct Buy"

  final int id;
  final String rent_type;
  final double pay_per_duration;

  RentRequestModel({
    required this.id,
    required this.rent_type,
    required this.pay_per_duration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rent_type': rent_type,
      'pay_per_duration': pay_per_duration,
    };
  }

  factory RentRequestModel.fromMap(Map<String, dynamic> map) {
    return RentRequestModel(
      id: map['id'] as int,
      rent_type: map['rent_type'] as String,
      pay_per_duration: map['pay_per_duration'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentRequestModel.fromJson(String source) =>
      RentRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
