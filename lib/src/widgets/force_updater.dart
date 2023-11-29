import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:coody_common_flutter/src/utils/app_version_checker.dart';
import 'package:coody_common_flutter/src/widgets/dialog_frames.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

/// 강제 업데이트 팝업 표시 Widget
/// - 현재 버전이 기준 최소 지원 버전보다 낮을 경우 팝업 표시
/// - 팝업 닫기 불가
class ForceUpdater extends StatefulWidget {
  const ForceUpdater({
    super.key,
    required this.appVersionChecker,
    required this.appId,
    required this.title,
    required this.body,
    required this.buttonText,
    required this.child,
  });

  final AppVersionChecker appVersionChecker;
  final String appId;
  final Widget title;
  final Widget body;
  final Widget buttonText;
  final Widget child;

  @override
  State<ForceUpdater> createState() => _ForceUpdaterState();
}

class _ForceUpdaterState extends State<ForceUpdater> {
  @override
  void initState() {
    widget.appVersionChecker.isOutdated().then((value) {
      if (value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return PopScope(
              canPop: false,
              child: DialogFrame(
                title: widget.title,
                body: widget.body,
                rightButton: AppButton(
                  onPressed: () => StoreRedirect.redirect(
                    androidAppId: widget.appId,
                    iOSAppId: widget.appId,
                  ),
                  child: widget.buttonText,
                ),
              ),
            );
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
