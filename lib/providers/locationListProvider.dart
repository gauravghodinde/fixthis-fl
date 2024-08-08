import 'package:fixthis/model/locationlist.dart';
import 'package:flutter/material.dart';

class LocationListProvider extends ChangeNotifier {
  LocationList _locationList = LocationList(
    locationlist: [],
  );

  LocationList get loactionlist => _locationList;

  void setLocationList(String locationlist) {
    _locationList = LocationList.fromJson(locationlist);
    notifyListeners();
  }

  void setLocationListFromModel(LocationList locationlist) {
    _locationList = locationlist;
    notifyListeners();
  }
}
