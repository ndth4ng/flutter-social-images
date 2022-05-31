import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.all(16.0),
  fillColor: Colors.grey[200],
  filled: true,
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.white,
      width: 0.0,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.blue,
      width: 1.0,
    ),
  ),
  hintStyle: const TextStyle(
    fontSize: 12.0,
    color: Colors.grey,
  ),
  isDense: true,
);
