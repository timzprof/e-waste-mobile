import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class HelperFunctions {
  const HelperFunctions();

  static void displayError(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 10),
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: errorMsg,
          contentType: ContentType.failure,
        )));
  }

  static void showSnackBar(BuildContext context, String message,
      {ContentType? contentType}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 4),
      content: AwesomeSnackbarContent(
        title: 'Info',
        message: message,
        contentType: contentType ?? ContentType.success,
      ),
    ));
  }

  static void showAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
