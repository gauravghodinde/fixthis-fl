import 'package:fixthis/services/auth_services.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key, required this.userId});
  // const String userId;
  final String userId;
  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _receiversNameController =
      TextEditingController();
  final TextEditingController _receiversContactController =
      TextEditingController();
  final TextEditingController _addressTypeController = TextEditingController();
  final TextEditingController _flatHouseFloorBuildingController =
      TextEditingController();
  final TextEditingController _nearbyLandmarkController =
      TextEditingController();

  // Method to post data to the server
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      AuthService authService = AuthService();

      print("sending");
      try {
        http.Response res = await http.post(
          Uri.parse('${Constants.uri}location/add'),
          // body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
            'userId': widget.userId,
            'ReceiversName': _receiversNameController.text,
            'ReceiversContact': _receiversContactController.text,
            'AddressType': _addressTypeController.text,
            'FlatHouseFloorBuilding': _flatHouseFloorBuildingController.text,
            'nearbyLandmark': _nearbyLandmarkController.text,
          }),
        );
        print(res.body);
        if (res.statusCode < 300) {
          // Success: Show a success message or navigate away
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location added successfully')),
          );
          authService.fetchLocations(context: context, userid: widget.userId);
          Navigator.pop(context);
        } else {
          // Failure: Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add location: ${res.body}')),
          );
        }
      } catch (e) {
        // Error handling
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _receiversNameController,
                decoration: InputDecoration(labelText: 'Receiver\'s Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the receiver\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _receiversContactController,
                decoration: InputDecoration(labelText: 'Receiver\'s Contact'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the receiver\'s contact';
                  }
                  if (value.length != 10) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressTypeController,
                decoration: InputDecoration(labelText: 'Address Type'),
              ),
              TextFormField(
                controller: _flatHouseFloorBuildingController,
                decoration:
                    InputDecoration(labelText: 'Flat/House/Floor/Building'),
              ),
              TextFormField(
                controller: _nearbyLandmarkController,
                decoration: InputDecoration(labelText: 'Nearby Landmark'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _receiversNameController.dispose();
    _receiversContactController.dispose();
    _addressTypeController.dispose();
    _flatHouseFloorBuildingController.dispose();
    _nearbyLandmarkController.dispose();
    super.dispose();
  }
}
