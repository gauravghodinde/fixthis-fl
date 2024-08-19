import 'package:fixthis/pages/loaction_selector_page.dart';
import 'package:fixthis/providers/DeliveryLocationProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationRequestCard extends StatelessWidget {
  const LocationRequestCard({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    final _location = Provider.of<LocationProvider>(context).loaction;
    final _deliverylocation =
        Provider.of<DeliveryLocationProvider>(context).loaction;
    final _user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return locationSelector(
                type: type,
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white54,
          border: Border.all(
            color: Colors.grey[400]!, // border color
            width: .0, // border width
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${type} Location",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(Constants.mainColorHsh),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                type == "Delivery"
                                    ? _deliverylocation.AddressType
                                    : _location.AddressType,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Text(
                              "${_user.phoneNumber} ${type == "Delivery" ? _deliverylocation.FlatHouseFloorBuilding : _location.FlatHouseFloorBuilding}",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
