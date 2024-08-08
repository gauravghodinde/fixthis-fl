import 'package:flutter/material.dart';

class locationSelector extends StatelessWidget {
  const locationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ElevatedButton(
          child: Text("close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
