// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fixthis/model/repairRequest.dart';

class RepairRequestList {
  final List<RepairRequest> repairRequestList;

  RepairRequestList({required this.repairRequestList});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'repairRequestList': repairRequestList.map((x) => x.toMap()).toList(),
    };
  }

  factory RepairRequestList.fromMap(Map<String, dynamic> map) {
    return RepairRequestList(
      repairRequestList: List<RepairRequest>.from(
        (map['body'] as List<dynamic>).map<RepairRequest>(
          (x) => RepairRequest.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairRequestList.fromJson(String source) =>
      RepairRequestList.fromMap(json.decode(source) as Map<String, dynamic>);
}
