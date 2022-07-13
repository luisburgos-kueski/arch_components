import 'package:flutter/material.dart';

extension KeyStringValue on Key? {
  String get value {
    return (this as ValueKey<String>?)?.value ?? '';
  }
}
