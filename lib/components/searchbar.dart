import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchBarHome extends StatelessWidget {
  SearchBarHome({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                blurStyle: BlurStyle.outer),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Color(Constants.mainColorHsh),
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(hintText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
