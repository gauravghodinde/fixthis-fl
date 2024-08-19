import 'package:fixthis/model/location.dart';
import 'package:flutter/material.dart';

class DeliveryLocationProvider extends ChangeNotifier {
  Location _deliveryLocation = Location(
    id: "",
    ReceiversName: "",
    ReceiversContact: "",
    AddressType: "",
    FlatHouseFloorBuilding: "",
    nearbyLandmark: "",
  );

  Location get loaction => _deliveryLocation;

  void setDeliveryLocation(String deliveryLocation) {
    _deliveryLocation = Location.fromJson(deliveryLocation);
    notifyListeners();
  }

  void setDeliveryLocationFromModel(Location deliveryLocation) {
    _deliveryLocation = deliveryLocation;
    notifyListeners();
  }
}
