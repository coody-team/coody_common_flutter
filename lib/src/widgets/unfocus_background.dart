import 'package:flutter/material.dart';

/// 배경 터치 시 포커스 해제시키는 Widget
class UnfocusBackground extends StatelessWidget {
  const UnfocusBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocus(context);
      },
      child: Container(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}

/// Focus 해제
/// - FocusScope.of(context).unfocus()로 처리 시 포커스 재요청이 정상 동작하지 않는 경우 있음.
/// - FocusScope.of(context).requestFocus(FocusNode())로 처리 시 TextInputAction.next 정상 동작하지 않음.
void unfocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.focusedChild?.unfocus();
  }
}
