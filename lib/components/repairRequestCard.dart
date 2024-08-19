import 'package:flutter/material.dart';
import 'package:fixthis/model/repairRequest.dart';

class RepairRequestCard extends StatelessWidget {
  const RepairRequestCard({super.key, required this.repairRequest});

  final RepairRequest repairRequest;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the image
            Image.network(
              repairRequest.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              (progress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error, color: Colors.red[800]),
                );
              },
            ),
            const SizedBox(height: 8),
            // Display the description
            Text(
              repairRequest.description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            // Display the status
            Text(
              'Status: ${repairRequest.status}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            // Display the pickup and delivery addresses
            Text(
              'Pickup Address: ${repairRequest.pickupAddress}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              'Delivery Address: ${repairRequest.deliveryAddress}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            // Display the date and time
            Text(
              'Request Date: ${_formatDate(repairRequest.dateTime)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to format date
  String _formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}';
  }
}
