import 'dart:convert';
import 'package:fixthis/model/location.dart';

class LocationList {
  final List<Location> locationlist;

  LocationList({required this.locationlist});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationlist': locationlist.map((x) => x.toMap()).toList(),
    };
  }

  factory LocationList.fromMap(Map<String, dynamic> map) {
    return LocationList(
      locationlist: List<Location>.from(
        (map['body'] as List<dynamic>).map<Location>(
          (x) => Location.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationList.fromJson(String source) =>
      LocationList.fromMap(json.decode(source) as Map<String, dynamic>);
}
