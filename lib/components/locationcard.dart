import 'package:fixthis/model/location.dart';
import 'package:fixthis/pages/categoryseachpage.dart';
import 'package:fixthis/providers/DeliveryLocationProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
import 'package:fixthis/providers/userProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.location, required this.type});
  final String type;
  final Location location;
  @override
  Widget build(BuildContext context) {
    var _locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    var _deliverylocationProvider =
        Provider.of<DeliveryLocationProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: GestureDetector(
        onTap: () {
          print("clicked geust ${type}");
          if (type == "Delivery")
            _deliverylocationProvider.setDeliveryLocationFromModel(location);
          else
            _locationProvider.setLocationFromModel(location);

          Navigator.pop(context);
        },
        child: Container(
          // width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white30,
            border: Border.all(
              color: Colors.grey[400]!, // border color
              width: 0.5, // border width
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.black87,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              location.AddressType,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              location.FlatHouseFloorBuilding,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      print("pressed icon");
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.grey[600]!,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
