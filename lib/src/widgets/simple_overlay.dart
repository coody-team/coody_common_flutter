
import 'package:flutter/material.dart';

/// [OverlayEntry] 생성, 삭제 및 상태 관리 기능 제공
/// - [OverlayEntry]는 별도 Widget Tree로 구성되어 [SimpleOverlay] Widget Tree 변경 발생 시 rebuild되지 않음
/// - [SimpleOverlay]는 Widget 변경 발생 시 [OverlayEntry]를 rebuild하여 상태를 갱신함
class SimpleOverlay extends StatefulWidget {
  const SimpleOverlay({
    super.key,
    this.showOverlay = false,
    required this.overlayBuilder,
    // required this.overlay,
    required this.child,
  });

  /// OverlayEntry 표시 여부
  final bool showOverlay;

  /// Overlay에 표시될 Widget builder
  /// - [context] : [OverlayEntry] Widget Tree의 [BuildContext]. [OverlayEntry]는 [SimpleOverlay]와 다른 Widget Tree에 구성됨.
  final Widget Function(BuildContext context) overlayBuilder;
  // final Widget overlay;
  final Widget child;

  @override
  State<SimpleOverlay> createState() => SimpleOverlayState();
}

class SimpleOverlayState extends State<SimpleOverlay> {
  final _widgetKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  bool get _isOverlayOpened => _overlayEntry != null;

  @override
  void didUpdateWidget(covariant SimpleOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showOverlay != oldWidget.showOverlay) {
      if (widget.showOverlay) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _openOverlay();
        });
      } else {
        _closeOverlay();
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _overlayEntry?.markNeedsBuild();
      });
    }
  }

  @override
  void dispose() {
    _closeOverlay();
    super.dispose();
  }

  /// 화면에서의 Widget 크기, 위치 정보
  _SizePosition _getWidgetInfo() {
    RenderBox? renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    final widgetSize = renderBox?.size;
    final widgetPosition = renderBox?.localToGlobal(Offset.zero);

    return _SizePosition(widgetSize, widgetPosition);
  }

  OverlayEntry? _buildOverlayEntry() {
    final widgetInfo = _getWidgetInfo();
    if (widgetInfo.size == null || widgetInfo.position == null) return null;

    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Positioned(
          top: widgetInfo.position!.dy + widgetInfo.size!.height,
          left: widgetInfo.position!.dx,
          width: widgetInfo.size!.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(0.0, widgetInfo.size!.height),
            showWhenUnlinked: false,
            child: Material(
              color: Colors.transparent,
              child: widget.overlayBuilder(context),
            ),
          ),
        );
      },
    );
  }

  void _openOverlay() {
    if (_isOverlayOpened) _closeOverlay();

    _overlayEntry = _buildOverlayEntry();
    if (_overlayEntry != null) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _closeOverlay() {
    _overlayEntry
      ?..remove()
      ..dispose();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      key: _widgetKey,
      link: _layerLink,
      child: widget.child,
    );
  }
}

class _SizePosition {
  Size? size;
  Offset? position;

  _SizePosition(this.size, this.position);
}
