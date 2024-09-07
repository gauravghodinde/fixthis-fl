import 'package:fixthis/model/repairRequest.dart';
import 'package:fixthis/providers/pendingActionProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  final RepairRequest repairRequest;

  RequestPage({super.key, required this.repairRequest});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  // final TextEditingController commentController = TextEditingController();
  AuthService authService = AuthService();
  List<TextEditingController> commentControllers = [];

  @override
  void initState() {
    super.initState();
    // Fetch pending actions for the repair request
    authService.getRepairRequestsPendingAction(
      context: context,
      repairRequestId: widget.repairRequest.id,
    );
  }

  @override
  void dispose() {
    // Dispose of each TextEditingController to avoid memory leaks
    for (var controller in commentControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of pending actions from the provider
    var pendingActionList =
        Provider.of<PendingActionListProvider>(context, listen: true)
            .pendingActionList
            .pendingActionList;
    print("awjojasf");
    print(pendingActionList);

    if (commentControllers.length != pendingActionList.length) {
      commentControllers = List.generate(
          pendingActionList.length, (_) => TextEditingController());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Actions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: !pendingActionList.isEmpty
            ? ListView.builder(
                itemCount: pendingActionList.length,
                itemBuilder: (context, index) {
                  var action = pendingActionList[index];
                  var commentController = commentControllers[index];
                  var PendingActionId = pendingActionList[index].id;
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Action: ${action.action}', // Display action message
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Status: ${action.response}', // Display current response status
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          if (action.response == "Waiting") ...[
                            // Comment TextField
                            TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                labelText: 'Add a comment',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),

                            // Accept/Reject Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Accept Button
                                ElevatedButton(
                                  onPressed: () {
                                    handleAction(
                                        'accepted',
                                        commentController.text,
                                        PendingActionId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: Text('Accept'),
                                ),
                                // Reject Button
                                ElevatedButton(
                                  onPressed: () {
                                    handleAction(
                                        'rejected',
                                        commentController.text,
                                        PendingActionId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text('Reject'),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(child: Text('No pending actions available')),
      ),
    );
  }

  void handleAction(String actionType, String comment, String PendingActionId) {
    authService.updatePendingAction(
      context: context,
      PendingActionId: PendingActionId,
      response: actionType,
      comment: comment,
    );
  }
}
