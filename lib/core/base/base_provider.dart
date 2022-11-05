import 'dart:developer';

import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  BaseProvider() {
    log("Provider", name: runtimeType.toString());
  }
}
