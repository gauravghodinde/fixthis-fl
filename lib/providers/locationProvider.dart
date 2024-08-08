import 'package:fixthis/model/location.dart';
import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  Location _location = Location(
    id: "",
    ReceiversName: "",
    ReceiversContact: "",
    AddressType: "",
    FlatHouseFloorBuilding: "",
    nearbyLandmark: "",
  );

  Location get loaction => _location;

  void setLocationList(String location) {
    _location = Location.fromJson(location);
    notifyListeners();
  }

  void setLocationListFromModel(Location location) {
    _location = location;
    notifyListeners();
  }
}
