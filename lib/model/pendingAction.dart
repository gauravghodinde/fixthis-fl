// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PendingAction {
  final String id;
  final String repairRequestId;
  final String action;
  final String comment;
  final String response;

  PendingAction({
    required this.id,
    required this.repairRequestId,
    required this.action,
    required this.comment,
    required this.response,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'repairRequestId': repairRequestId,
      'action': action,
      'comment': comment,
      'response': response,
    };
  }

  factory PendingAction.fromMap(Map<String, dynamic> map) {
    return PendingAction(
      id: map['_id'] as String,
      repairRequestId: map['repairRequestId'] as String,
      action: map['action'] as String,
      comment: map['comment'] as String,
      response: map['response'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingAction.fromJson(String source) =>
      PendingAction.fromMap(json.decode(source) as Map<String, dynamic>);
}
