import 'package:fixthis/model/pendingActionList.dart';
import 'package:flutter/material.dart';

class PendingActionListProvider extends ChangeNotifier {
  PendingActionList _pendingActionList = PendingActionList(
    pendingActionList: [],
  );

  PendingActionList get pendingActionList => _pendingActionList;

  void setPendingActionList(String pendingActionList) {
    _pendingActionList = PendingActionList.fromJson(pendingActionList);
    notifyListeners();
  }

  void setPendingActionListFromModel(PendingActionList pendingActionList) {
    _pendingActionList = pendingActionList;
    notifyListeners();
  }
}
