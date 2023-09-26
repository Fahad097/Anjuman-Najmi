import 'package:flutter/material.dart';

bool isLandscape(context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}
