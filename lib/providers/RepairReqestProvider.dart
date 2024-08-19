import 'package:fixthis/model/repairRequestList.dart';
import 'package:flutter/material.dart';

class RepairRequestListProvider extends ChangeNotifier {
  RepairRequestList _repairrequestList = RepairRequestList(
    repairRequestList: [],
  );

  RepairRequestList get repairRequestlist => _repairrequestList;

  void setRepairRequestList(String locationlist) {
    _repairrequestList = RepairRequestList.fromJson(locationlist);
    notifyListeners();
  }

  void setRepairRequestListFromModel(RepairRequestList locationlist) {
    _repairrequestList = locationlist;
    notifyListeners();
  }
}
