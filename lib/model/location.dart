// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Location {
  final String id;
  final String ReceiversName;
  final String ReceiversContact;
  final String AddressType;
  final String FlatHouseFloorBuilding;
  final String nearbyLandmark;

  Location({
    required this.id,
    required this.ReceiversName,
    required this.ReceiversContact,
    required this.AddressType,
    required this.FlatHouseFloorBuilding,
    required this.nearbyLandmark,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ReceiversName': ReceiversName,
      'ReceiversContact': ReceiversContact,
      'AddressType': AddressType,
      'FlatHouseFloorBuilding': FlatHouseFloorBuilding,
      'nearbyLandmark': nearbyLandmark,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['_id'] as String,
      ReceiversName: map['ReceiversName'] as String,
      ReceiversContact: map['ReceiversContact'] as String,
      AddressType: map['AddressType'] as String,
      FlatHouseFloorBuilding: map['FlatHouseFloorBuilding'] as String,
      nearbyLandmark: map['nearbyLandmark'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}
