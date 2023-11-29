import 'dart:async';

import 'package:coody_common_flutter/src/loading/utils/loading_streamer.dart';
import 'package:coody_common_flutter/src/loading/widgets/loading_indicator.dart';
import 'package:coody_common_flutter/src/styles/app_colors.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:flutter/material.dart';

/// Loading Indicator 표시 Overlay
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    this.isLoading = false,
    required this.child,
  });

  /// [isLoading]가 true일 경우 overlay 표시
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AbsorbPointer(
            child: Container(
              color: context.colors.background.opacity60,
              child: const Center(
                child: LoadingIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}

/// [LoadingStreamerMixin] 기반 [LoadingOverlay]
/// - [LoadingStreamerMixin]의 현재 상태를 초기값으로 반영
///
/// 기존 Rx.combineLatest를 통해 [LoadingStreamerMixin] 이벤트 통합하여 처리하였으나,
/// 특정 상황에서 이벤트를 수신하지 못하는 문제 발생하여 개별 [LoadingStreamerMixin] 이벤트 구독하는 방식으로 변경
class LoadingStreamersOverlay extends StatefulWidget {
  const LoadingStreamersOverlay({
    super.key,
    required this.loadingStreamers,
    required this.child,
  });

  final List<LoadingStreamerMixin> loadingStreamers;
  final Widget child;

  @override
  State<LoadingStreamersOverlay> createState() => _LoadingStreamersOverlayState();
}

class _LoadingStreamersOverlayState extends State<LoadingStreamersOverlay> {
  final List<StreamSubscription> _subscriptions = [];
  final Map<LoadingStreamerMixin, bool> _isLoadingMap = {};

  bool get _isLoading => _isLoadingMap.values.contains(true);

  @override
  void initState() {
    super.initState();

    for (var loadingStreamer in widget.loadingStreamers) {
      _isLoadingMap[loadingStreamer] = loadingStreamer.state.isLoading;

      final subscription = loadingStreamer.loadingStream.listen(
        (isLoading) {
          setState(() {
            _isLoadingMap[loadingStreamer] = isLoading;
          });
        },
      );

      _subscriptions.add(subscription);
    }
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: widget.child,
    );
  }
}
