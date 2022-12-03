import 'package:flutter/widgets.dart';

abstract class Pluggable {
  String get id;
  String get name;
  String get displayName;
  void onTrigger();
  Widget get buildWidget;
  IconData get iconData;
  PluginType get pluginType;
}

enum PluginType {
  screen,
  widget,
  service,
}
