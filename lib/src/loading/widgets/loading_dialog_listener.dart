import 'package:coody_common_flutter/src/loading/utils/loading_streamer.dart';
import 'package:coody_common_flutter/src/loading/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BlocListener]를 활용하여 Loading 살태일 때 [LoadingOverlay]를 Dialog 형태로 표시하는 Widget.
/// - [PopScope]를 통해 뒤로가기 차단
///
/// Modal Bottom Sheet 등 로딩 표시가 어려운 상황에서 사용할 수 있음
///
/// Issue
/// - BlocProvider 등록 후 바로 Loading 상태가 되는 경우 initial->loading 시점을 Listener에서 놓치는 현상이 있음
class LoadingDialogListener<B extends StateStreamable<S>, S extends LoadingState>
    extends BlocListener<B, S> {
  LoadingDialogListener({
    super.key,
    super.child,
  }) : super(
          listener: (context, state) {
            if (state.isLoading) {
              showLoadingDialog(context);
            } else {
              closeLoadingDialog(context);
            }
          },
          listenWhen: (previous, current) =>
              (previous.isLoading && !current.isLoading) ||
              (!previous.isLoading && current.isLoading),
        );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: const LoadingOverlay(
          isLoading: true,
          child: SizedBox(),
        ),
      );
    },
  );
}

void closeLoadingDialog(BuildContext context) => Navigator.of(context).pop();
