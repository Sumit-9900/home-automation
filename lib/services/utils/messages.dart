import 'package:flutter/material.dart';

void successMssg(BuildContext context, String mssg) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(mssg),
    ),
  );
}

void errorMssg(BuildContext context, String mssg) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(mssg),
    ),
  );
}
