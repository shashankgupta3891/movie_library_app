import 'package:flutter/material.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/helper/alice_conversion_helper.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_http_call.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/model/fluto_http_response.dart';

const _endpointMaxLines = 10;
const _serverMaxLines = 5;

class AliceCallListItemWidget extends StatelessWidget {
  final AliceHttpCall call;
  final Function itemClickAction;

  const AliceCallListItemWidget(this.call, this.itemClickAction);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => itemClickAction(call),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMethodAndEndpointRow(context),
                      const SizedBox(height: 4),
                      _buildServerRow(),
                      const SizedBox(height: 4),
                      _buildStatsRow()
                    ],
                  ),
                ),
                _buildResponseColumn(context)
              ],
            ),
          ),
          _buildDivider()
        ],
      ),
    );
  }

  Widget _buildMethodAndEndpointRow(BuildContext context) {
    final Color? textColor = _getEndpointTextColor(context);
    return Row(
      children: [
        Text(
          call.method,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Flexible(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Text(
              call.endpoint,
              maxLines: _endpointMaxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildServerRow() {
    return Row(
      children: [
        _getSecuredConnectionIcon(call.secure),
        Expanded(
          child: Text(
            call.server,
            overflow: TextOverflow.ellipsis,
            maxLines: _serverMaxLines,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            _formatTime(call.request!.time),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Flexible(
          child: Text(
            AliceConversionHelper.formatTime(call.duration),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Flexible(
          child: Text(
            "${AliceConversionHelper.formatBytes(call.request!.size)} / "
            "${AliceConversionHelper.formatBytes(call.response!.size)}",
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: Colors.grey[300]);
  }

  String _formatTime(DateTime time) {
    return "${formatTimeUnit(time.hour)}:"
        "${formatTimeUnit(time.minute)}:"
        "${formatTimeUnit(time.second)}:"
        "${formatTimeUnit(time.millisecond)}";
  }

  String formatTimeUnit(int timeUnit) {
    return (timeUnit < 10) ? "0$timeUnit" : "$timeUnit";
  }

  Widget _buildResponseColumn(BuildContext context) {
    final List<Widget> widgets = [];
    if (call.loading) {
      widgets.add(
        const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      );
      widgets.add(
        const SizedBox(
          height: 4,
        ),
      );
    }
    widgets.add(
      Text(
        _getStatus(call.response!),
        style: TextStyle(
          fontSize: 16,
          color: _getStatusTextColor(context),
        ),
      ),
    );
    return SizedBox(
      width: 50,
      child: Column(
        children: widgets,
      ),
    );
  }

  Color? _getStatusTextColor(BuildContext context) {
    final int? status = call.response!.status;
    if (status == -1) {
      return Colors.red;
    } else if (status! < 200) {
      return Theme.of(context).textTheme.bodyText1!.color;
    } else if (status >= 200 && status < 300) {
      return Colors.green;
    } else if (status >= 300 && status < 400) {
      return Colors.orange;
    } else if (status >= 400 && status < 600) {
      return Colors.red;
    } else {
      return Theme.of(context).textTheme.bodyText1!.color;
    }
  }

  Color? _getEndpointTextColor(BuildContext context) {
    if (call.loading) {
      return Colors.grey;
    } else {
      return _getStatusTextColor(context);
    }
  }

  String _getStatus(AliceHttpResponse response) {
    if (response.status == -1) {
      return "ERR";
    } else if (response.status == 0) {
      return "???";
    } else {
      return "${response.status}";
    }
  }

  Widget _getSecuredConnectionIcon(bool secure) {
    IconData iconData;
    Color iconColor;
    if (secure) {
      iconData = Icons.lock_outline;
      iconColor = Colors.green;
    } else {
      iconData = Icons.lock_open;
      iconColor = Colors.red;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Icon(
        iconData,
        color: iconColor,
        size: 12,
      ),
    );
  }
}
