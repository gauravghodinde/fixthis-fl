import 'package:fixthis/pages/loaction_selector_page.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';

class locationAppBar extends StatelessWidget {
  const locationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                      return locationSelector();
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
                        return locationSelector();
                      });
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Title Location",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      Text(
                        "main Location",
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle_rounded,
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
