import 'dart:ui';

import 'package:flutter/material.dart';

Color getStatusColor(String? status) {
  if (status == "Active") {
    return Colors.green;
  } else if (status == "Block") {
    return Colors.red;
  } else if (status == "Not Active") {
    return Colors.amberAccent;
  }
  return Colors.black38;
}
