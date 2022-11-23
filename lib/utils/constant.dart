import 'package:flutter/material.dart';
import 'package:microsoft/utils/sizeconfig.dart';

import '../theme/colors.dart';

InputDecoration reuseDecoration(IconData icon,String hint) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Colors.black.withOpacity(.7)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(screenWidth(20)))),
    hintText: hint,
    labelStyle:
        const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(screenWidth(20))),
      borderSide: BorderSide(color: green, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(screenWidth(20))),
      borderSide: BorderSide(color: blue, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(screenWidth(20))),
      borderSide: const BorderSide(color: Color(0xFFee7b64), width: 2),
    ),
  );
}
