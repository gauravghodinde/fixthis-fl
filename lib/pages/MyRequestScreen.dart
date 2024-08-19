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
  // late String userid;
  // @override
  // void initState() {
  //   super.initState();
  //   final user = Provider.of<UserProvider>(context, listen: false).user;
  //   userid = user.id;
  // }

  @override
  Widget build(BuildContext context) {
    var _repairRequestListProvider =
        Provider.of<RepairRequestListProvider>(context, listen: false)
            .repairRequestlist;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Requests"),
      ),
      body: SafeArea(
        // child: Center(
        //   child: Text("sfsg"),
        // ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: _repairRequestListProvider.repairRequestList.length,
              // itemCount: 10,
              // crossAxisAlignment: CrossAxisAlignment.start,
              itemBuilder: (context, j) {
                // return Text(
                // _repairRequestListProvider.repairRequestList[j].status);
                return RepairRequestCard(
                  repairRequest:
                      _repairRequestListProvider.repairRequestList[j],
                );
              }),
        ),
      ),
    );
  }
}
