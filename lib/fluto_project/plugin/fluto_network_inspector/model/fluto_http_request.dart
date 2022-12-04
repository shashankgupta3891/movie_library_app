import 'dart:io';

import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_form_data_field.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_form_data_file.dart';

class AliceHttpRequest {
  int size = 0;
  DateTime time = DateTime.now();
  Map<String, dynamic> headers = <String, dynamic>{};
  dynamic body = "";
  String? contentType = "";
  List<Cookie> cookies = [];
  Map<String, dynamic> queryParameters = <String, dynamic>{};
  List<AliceFormDataFile>? formDataFiles;
  List<AliceFormDataField>? formDataFields;
}
