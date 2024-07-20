import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressModel {
  //       "address": {
  //           "id": 1,
  //           "address": "bal sath colony",
  //           "pin_code": 136027,
  //           "city": "Kaithal",
  //           "state": "Haryana",
  //           "country": "India",
  //           "latitude": 78907.0,
  //           "longitude": 9898.0,
  //           "user": 3
  //       },
  final int id;
  final String address;
  final int pin_code;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;
  final int user;

  AddressModel({
    required this.id,
    required this.address,
    required this.pin_code,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'pin_code': pin_code,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'user': user,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      address: map['address'] as String,
      pin_code: map['pin_code'] as int,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      user: map['user'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
