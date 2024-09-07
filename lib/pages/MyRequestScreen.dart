import 'package:fixthis/components/repairRequestCard.dart';
import 'package:fixthis/providers/RepairReqestProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({super.key});

  @override
  State<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  String val = "cancelled by user";
  String seeall = "See All Requests";
  String seeActive = "See Only Active";
  String curButtonval = "See All Requests";
  @override
  Widget build(BuildContext context) {
    var _repairRequestListProvider =
        Provider.of<RepairRequestListProvider>(context, listen: true)
            .repairRequestlist;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Requests"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (curButtonval == seeall) {
                    val = "";
                    curButtonval = seeActive;
                  } else {
                    val = "cancelled by user";
                    curButtonval = seeall;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(curButtonval),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: _repairRequestListProvider.repairRequestList.length,
              itemBuilder: (context, j) {
                return (_repairRequestListProvider
                            .repairRequestList[j].status !=
                        val
                    ? RepairRequestCard(
                        repairRequest:
                            _repairRequestListProvider.repairRequestList[j],
                      )
                    : SizedBox.shrink());
              }),
        ),
      ),
    );
  }
}
