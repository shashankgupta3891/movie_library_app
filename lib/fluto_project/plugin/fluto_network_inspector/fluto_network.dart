import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/core/fluto_network_core.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/core/fluto_network_interceptor.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_http_call.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_network_log.dart';

class FlutoNetwork {
  ///Max number of calls that are stored in memory. When count is reached, FIFO
  ///method queue will be used to remove elements.
  final int maxCallsCount;

  ///Directionality of app. Directionality of the app will be used if set to null.
  final TextDirection? directionality;

  ///Flag used to show/hide share button
  final bool? showShareButton;

  late FlutoNetworkCore _aliceCore;

  FlutoNetworkCore get aliceCore => _aliceCore;

  /// Creates alice instance.
  FlutoNetwork({
    this.maxCallsCount = 1000,
    this.directionality,
    this.showShareButton = true,
  }) {
    _aliceCore = FlutoNetworkCore(
      maxCallsCount: maxCallsCount,
      directionality: directionality,
      showShareButton: showShareButton,
    );
  }

  /// Get Dio interceptor which should be applied to Dio instance.
  AliceDioInterceptor getDioInterceptor() {
    return AliceDioInterceptor(_aliceCore);
  }

  /// Handle generic http call. Can be used to any http client.
  void addHttpCall(AliceHttpCall aliceHttpCall) {
    assert(aliceHttpCall.request != null, "Http call request can't be null");
    assert(aliceHttpCall.response != null, "Http call response can't be null");
    _aliceCore.addCall(aliceHttpCall);
  }

  /// Adds new log to Alice logger.
  void addLog(AliceLog log) {
    _aliceCore.addLog(log);
  }

  /// Adds list of logs to Alice logger
  void addLogs(List<AliceLog> logs) {
    _aliceCore.addLogs(logs);
  }
}
