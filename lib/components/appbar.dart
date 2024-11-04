import 'package:fixthis/model/location.dart';
import 'package:fixthis/pages/loaction_selector_page.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';

class locationAppBar extends StatelessWidget {
  const locationAppBar({super.key, required this.location});
  final Location location;
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    void _logout() {
      authService.SignOut(context);
    }

    return SliverAppBar(
      floating: false,
      snap: false,
      backgroundColor: Colors.transparent,
      expandedHeight: kToolbarHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Row(
          children: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return locationSelector(
                        type: "pickUp",
                      );
                    });
              },
              icon: Icon(
                Icons.location_on,
                color: Color(Constants.mainColorHsh),
                size: 32,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return locationSelector(
                          type: "pickUp",
                        );
                      });
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            location.AddressType == ""
                                ? "Select a Location"
                                : location.AddressType,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      Text(
                        location.FlatHouseFloorBuilding == ""
                            ? "click here to select a location"
                            : location.FlatHouseFloorBuilding,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _logout();
              },
              icon: Icon(
                Icons.login_rounded,
                color: Color(Constants.mainColorHsh),
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
