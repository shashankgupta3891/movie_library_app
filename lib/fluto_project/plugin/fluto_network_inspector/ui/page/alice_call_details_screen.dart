import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/helper/fluto_save_helper.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_http_call.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/ui/widget/alice_call_error_widget.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/ui/widget/alice_call_overview_widget.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/ui/widget/alice_call_request_widget.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/ui/widget/alice_call_response_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/fluto_network_core.dart';

class AliceCallDetailsScreen extends StatefulWidget {
  final AliceHttpCall call;
  final FlutoNetworkCore core;

  const AliceCallDetailsScreen(this.call, this.core);

  @override
  _AliceCallDetailsScreenState createState() => _AliceCallDetailsScreenState();
}

class _AliceCallDetailsScreenState extends State<AliceCallDetailsScreen>
    with SingleTickerProviderStateMixin {
  AliceHttpCall get call => widget.call;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.core.directionality ?? Directionality.of(context),
      child: StreamBuilder<List<AliceHttpCall>>(
        stream: widget.core.callsSubject,
        initialData: [widget.call],
        builder: (context, callsSnapshot) {
          if (callsSnapshot.hasData) {
            final AliceHttpCall? call = callsSnapshot.data!.firstWhereOrNull(
              (snapshotCall) => snapshotCall.id == widget.call.id,
            );
            if (call != null) {
              return _buildMainWidget();
            } else {
              return _buildErrorWidget();
            }
          } else {
            return _buildErrorWidget();
          }
        },
      ),
    );
  }

  Widget _buildMainWidget() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: widget.core.showShareButton == true
            ? FloatingActionButton(
                key: const Key('share_key'),
                onPressed: () async {
                  Share.share(
                    await _getSharableResponseString(),
                    subject: 'Request Details',
                  );
                },
                child: const Icon(
                  Icons.share,
                ),
              )
            : null,
        appBar: AppBar(
          bottom: TabBar(
            tabs: _getTabBars(),
          ),
          title: const Text('Alice - HTTP Call Details'),
        ),
        body: TabBarView(
          children: _getTabBarViewList(),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(child: Text("Failed to load data"));
  }

  Future<String> _getSharableResponseString() async {
    return AliceSaveHelper.buildCallLog(widget.call);
  }

  List<Widget> _getTabBars() {
    final List<Widget> widgets = [];
    widgets.add(const Tab(icon: Icon(Icons.info_outline), text: "Overview"));
    widgets.add(const Tab(icon: Icon(Icons.arrow_upward), text: "Request"));
    widgets.add(const Tab(icon: Icon(Icons.arrow_downward), text: "Response"));
    widgets.add(
      const Tab(
        icon: Icon(Icons.warning),
        text: "Error",
      ),
    );
    return widgets;
  }

  List<Widget> _getTabBarViewList() {
    final List<Widget> widgets = [];
    widgets.add(AliceCallOverviewWidget(widget.call));
    widgets.add(AliceCallRequestWidget(widget.call));
    widgets.add(AliceCallResponseWidget(widget.call));
    widgets.add(AliceCallErrorWidget(widget.call));
    return widgets;
  }
}
