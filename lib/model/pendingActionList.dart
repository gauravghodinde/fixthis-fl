// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fixthis/model/pendingAction.dart';

class PendingActionList {
  final List<PendingAction> pendingActionList;

  PendingActionList({required this.pendingActionList});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingActionList': pendingActionList.map((x) => x.toMap()).toList(),
    };
  }

  factory PendingActionList.fromMap(Map<String, dynamic> map) {
    return PendingActionList(
      pendingActionList: List<PendingAction>.from(
        (map['body'] as List<dynamic>).map<PendingAction>(
          (x) => PendingAction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingActionList.fromJson(String source) =>
      PendingActionList.fromMap(json.decode(source) as Map<String, dynamic>);
}
