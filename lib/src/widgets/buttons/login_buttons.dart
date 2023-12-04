import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:coody_common_flutter/styles.dart';
import 'package:coody_common_flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _basePath = 'assets/logos/';

/// Google 로그인 버튼
class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final Widget label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _BaseLoginButton(
      logoAssetPath: '${_basePath}google_logo.svg',
      label: label,
      onTap: onTap,
    );
  }
}

/// Apple 로그인 버튼
class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final Widget label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _BaseLoginButton(
      logoAssetPath: '${_basePath}apple_logo_black.svg',
      label: label,
      color: Theme.of(context).brightness == Brightness.light ? null : Colors.white,
      onTap: onTap,
    );
  }
}

class _BaseLoginButton extends StatelessWidget {
  const _BaseLoginButton({
    required this.logoAssetPath,
    required this.label,
    this.color,
    this.onTap,
  });

  final String logoAssetPath;
  final Widget label;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton.withIcon(
      style: context.buttonThemes.primary.filled.xlarge.copyWith(
        backgroundColor: MaterialStatePropertyUtil.simple(
          enabled: context.colors.gray2,
          disabled: context.colors.disabledBackgroundColor,
        ),
        minimumSize: MaterialStatePropertyAll(Size.fromHeight(0.0)),
      ),
      onPressed: onTap,
      icon: SvgPicture.asset(
        logoAssetPath,
        height: 24.0,
        width: 24.0,
        theme: color != null ? SvgTheme(currentColor: color!) : null,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcATop) : null,
      ),
      label: label,
    );
  }
}
