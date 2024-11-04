import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  // Handle success status codes
  if (response.statusCode < 300) {
    onSuccess();
  } else {
    // Default error message
    String errorMessage = 'Something went wrong';

    try {
      // Try to parse the response body
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode < 500) {
        // Handle client-side errors (4xx)
        errorMessage = responseBody['message'] ?? 'Client-side error';
      } else {
        // Handle server-side errors (5xx)
        errorMessage = responseBody['error'] ?? 'Server-side error';
      }   
    } catch (e) {
      // Handle JSON parsing errors
      errorMessage = 'Error parsing response: ${e.toString()}';
    }

    showSnackBar(context, errorMessage);
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 1}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(0.8, min(val, maxTextScaleFactor));
  }
}
