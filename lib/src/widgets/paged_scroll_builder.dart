import 'dart:async';

import 'package:flutter/widgets.dart';

/// Scroll 위치로 Paging 처리할 수 있는 Callback 제공
/// - builder를 통해 제공된 ScrollController를 통해 Scroll 위치 감지
class PagedScrollBuilder extends StatefulWidget {
  const PagedScrollBuilder({
    super.key,
    this.threshold = 0.9,
    required this.onThresholdReached,
    required this.builder,
  }) : assert(threshold >= 0.0 && threshold <= 1.0);

  /// [onThresholdReached]를 호출할 scroll 임계점
  /// - 0.9 -> 현재 스크롤이 전체 스크롤의 90% 이상 범위에 도달하면 [onThresholdReached] 호출
  final double threshold;

  /// [threshold]에 지정한 스크롤 범위에서 호출
  /// - [ScrollController] listener로 동작하기 때문에 여러번 호출될 수 있음
  final FutureOr<void> Function() onThresholdReached;

  final Widget Function(
    BuildContext context,
    ScrollController scrollController,
  ) builder;

  @override
  State<PagedScrollBuilder> createState() => _PagedScrollBuilderState();
}

class _PagedScrollBuilderState extends State<PagedScrollBuilder> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTresholdReached) widget.onThresholdReached();
  }

  /// 현재 스크롤 위치가 임계점 이상 범위에 있는지 확인
  bool get _isTresholdReached {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * widget.threshold);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _scrollController);
  }
}
