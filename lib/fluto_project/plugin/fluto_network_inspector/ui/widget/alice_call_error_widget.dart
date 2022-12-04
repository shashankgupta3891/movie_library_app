import 'package:flutter/material.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_http_call.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/ui/widget/alice_base_call_details_widget.dart';

class AliceCallErrorWidget extends StatefulWidget {
  final AliceHttpCall call;

  const AliceCallErrorWidget(this.call);

  @override
  State<StatefulWidget> createState() {
    return _AliceCallErrorWidgetState();
  }
}

class _AliceCallErrorWidgetState
    extends AliceBaseCallDetailsWidgetState<AliceCallErrorWidget> {
  AliceHttpCall get _call => widget.call;

  @override
  Widget build(BuildContext context) {
    if (_call.error != null) {
      final List<Widget> rows = [];
      final dynamic error = _call.error!.error;
      var errorText = "Error is empty";
      if (error != null) {
        errorText = error.toString();
      }
      rows.add(getListRow("Error:", errorText));

      return Container(
        padding: const EdgeInsets.all(6),
        child: ListView(children: rows),
      );
    } else {
      return const Center(child: Text("Nothing to display here"));
    }
  }
}
