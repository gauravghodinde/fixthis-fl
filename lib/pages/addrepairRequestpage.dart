import 'package:fixthis/components/locationrequest.dart';
import 'package:fixthis/model/product.dart';
import 'package:fixthis/providers/DeliveryLocationProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddRepairRequest extends StatefulWidget {
  final Product product;
  const AddRepairRequest({super.key, required this.product});
  @override
  State<AddRepairRequest> createState() => _AddRepairRequestState();
}

class _AddRepairRequestState extends State<AddRepairRequest> {
  bool _sameLocation = false;
  bool _makingRequest = false;
  String _pickupAddress = "";
  String _categoryId = "";
  String _productId = "";
  String _userId = "";
  String _deliveryAddress = "";
  String _description = "";
  // String _description = "";
  String imagePath = 'assets/images/iron.png';
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _makeRepairRequest() async {
    setState(() {
      _makingRequest = true;
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://ft-final.vercel.app/repair_request/add'));

    request.fields.addAll({
      'categoryId': _categoryId,
      'productId': _productId,
      'userId': _userId,
      'pickupAddress': _pickupAddress,
      'deliveryAddress': _deliveryAddress,
      'description': _descriptionController.text,
      'status': 'request raised'
    });
    print(request.fields);
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        // Handle successful response here
      } else {
        print(response.reasonPhrase);
        // Handle error here
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _makingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _location = Provider.of<LocationProvider>(context).loaction;
    final _deliverylocation =
        Provider.of<DeliveryLocationProvider>(context).loaction;
    final _user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      bottomNavigationBar: !_makingRequest
          ? GestureDetector(
              onTap: () {
                print("making request ${_makingRequest}");
                setState(() {
                  _pickupAddress = _location.FlatHouseFloorBuilding;
                  _userId = _user.id;
                  _deliveryAddress = _sameLocation
                      ? _location.FlatHouseFloorBuilding
                      : _deliverylocation.FlatHouseFloorBuilding;
                  _categoryId = widget.product.categoryId;
                  _productId = widget.product.id;
                });
                // setState(() {
                //   _makingRequest = !_makingRequest;
                // });
                _makeRepairRequest();
              },
              child: SizedBox(
                height: 70,
                child: Container(
                  color: Color(Constants.mainColorHsh),
                  child: Center(
                    child: Text("jasdpfj"),
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 70,
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Text("loading"),
                ),
              ),
            ),
      backgroundColor: const Color.fromARGB(255, 241, 243, 241)!,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        // actions: [],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              _location.FlatHouseFloorBuilding == ""
                  ? "select delivery address"
                  : _location.FlatHouseFloorBuilding,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white54,
                    border: Border.all(
                      color: Colors.grey[400]!, // border color
                      width: .0, // border width
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.image,
                              color: Color(Constants.mainColorHsh),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text("add image of your "),
                                    Text(
                                      "${widget.product.name}*",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                // isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          16,
                                          16,
                                          16,
                                          MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              16),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        // color: Colors.w,
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white54,
                                        border: Border.all(
                                          color:
                                              Colors.grey[400]!, // border color
                                          width: .0, // border width
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            // Text("Description"),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40,
                                              // height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                color: Colors.white54,
                                                border: Border.all(
                                                  color: Colors.green[
                                                      500]!, // border color
                                                  width: .0, // border width
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    // Text(
                                                    //   "Add Description of the repair",
                                                    //   style: TextStyle(
                                                    //     fontWeight: FontWeight.w500,
                                                    //     fontSize: 18,
                                                    //   ),
                                                    // ),
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      controller:
                                                          _descriptionController,
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "enter the discription",
                                                          focusColor:
                                                              Colors.black26,
                                                          fillColor:
                                                              Colors.black45),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _description =
                                                                _descriptionController
                                                                    .text;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(Icons.close))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).whenComplete(() {
                              setState(() {
                                _description = _descriptionController.text;
                              });
                              ;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.text_snippet_outlined,
                                color: Color(Constants.mainColorHsh),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Desription of the Product / Note for repairing",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        _description,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  // crossAxisAlignment: ,
                  children: [
                    LocationRequestCard(
                      type: "Pickup",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white54,
                        border: Border.all(
                          color: Colors.grey[400]!, // border color
                          width: .0, // border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery address is same as pickup address"),
                            Checkbox(
                                value: _sameLocation,
                                onChanged: (val) {
                                  setState(() {
                                    _sameLocation = !_sameLocation;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    !_sameLocation
                        ? LocationRequestCard(type: "Delivery")
                        : Text("delivery location is same as pickup location"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
