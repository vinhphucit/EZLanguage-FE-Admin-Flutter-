import 'package:fe_ezlang_admin/core/constants/colors.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK")),
          ],
        );
      });
}

void showAlertDialog(
    BuildContext context, String title, String content, Function function) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            title: Center(
              child: Column(
                children: [
                  Icon(Icons.warning_outlined, size: 36, color: Colors.red),
                  SizedBox(height: 20),
                  Text("Confirm Deletion"),
                ],
              ),
            ),
            content: Container(
              color: secondaryColor,
              height: 70,
              child: Column(
                children: [
                  Text(content),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          icon: Icon(
                            Icons.close,
                            size: 14,
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          label: Text("No")),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton.icon(
                          icon: Icon(
                            Icons.delete,
                            size: 14,
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            function();
                          },
                          label: Text("Yes"))
                    ],
                  )
                ],
              ),
            ));
      });
}
