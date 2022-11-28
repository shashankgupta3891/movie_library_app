import 'dart:developer' as developer;

import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  BaseProvider() {
    // log("Provider Started");
  }

  void log(Object? object) {
    String line = "$object";
    if (false) {
      developer.log(line, name: runtimeType.toString());
    }
  }
}
