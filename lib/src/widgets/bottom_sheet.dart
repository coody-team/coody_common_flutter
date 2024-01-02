import 'package:coody_common_flutter/src/image/widgets/image_list_view.dart';
import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:coody_common_flutter/src/widgets/buttons/function_button.dart';
import 'package:coody_common_flutter/src/widgets/buttons/left_aligned_outlined_button.dart';
import 'package:coody_common_flutter/src/widgets/selections/select_tiles.dart';
import 'package:coody_common_flutter/src/widgets/selections/time_picker.dart';
import 'package:flutter/material.dart';

Future<void> showAppModalBottomSheet(
  BuildContext context, {
  required Widget Function(BuildContext context) builder,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return SingleChildScrollView(
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child: builder(context),
        ),
      );
    },
  );
}

const _bottomSheetPadding = EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0);

class BottomSheetFrame extends StatelessWidget {
  const BottomSheetFrame({
    super.key,
    required this.title,
    required this.body,
    required this.rightButton,
    this.leftButton,
  });

  final Widget title;
  final Widget body;
  final Widget rightButton;
  final Widget? leftButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bottomSheetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: context.typography.largeTitle2.emphasized,
            child: title,
          ),
          const SizedBox(height: 8.0),
          DefaultTextStyle(
            style: context.typography.body2.normal,
            child: body,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              if (leftButton != null) ...[
                Expanded(
                  child: AppButtonTheme(
                    data: AppButtonThemeData(
                      style: context.buttonThemes.primary.none.medium,
                    ),
                    child: leftButton!,
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
              Expanded(
                child: AppButtonTheme(
                  data: AppButtonThemeData(
                    style: context.buttonThemes.primary.filled.medium,
                  ),
                  child: rightButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetImageFrame extends StatelessWidget {
  const BottomSheetImageFrame({
    super.key,
    required this.title,
    required this.body,
    required this.imageUrls,
    this.onImageTap,
    this.onImageRemoveTap,
    this.onImageAddTap,
  });

  final Widget title;
  final Widget body;
  final List<String> imageUrls;
  final void Function(int index)? onImageTap;
  final void Function(int index)? onImageRemoveTap;
  final void Function()? onImageAddTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: _bottomSheetPadding.top,
        bottom: _bottomSheetPadding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: _bottomSheetPadding.left,
              right: _bottomSheetPadding.right,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: context.typography.largeTitle2.emphasized,
                  child: title,
                ),
                const SizedBox(height: 8.0),
                DefaultTextStyle(
                  style: context.typography.body2.normal,
                  child: body,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
          ImageListView(
            imageUrls: imageUrls,
            onImageTap: onImageTap,
            onImageRemoveTap: onImageRemoveTap,
            onImageAddTap: onImageAddTap,
          )
        ],
      ),
    );
  }
}

class BottomSheetSelectionFrame extends StatelessWidget {
  const BottomSheetSelectionFrame({
    super.key,
    required this.title,
    required this.body,
    required this.buttons,
  });

  final Widget title;
  final Widget body;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bottomSheetPadding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: context.typography.largeTitle2.emphasized,
              child: title,
            ),
            const SizedBox(height: 8.0),
            DefaultTextStyle(
              style: context.typography.body2.normal,
              child: body,
            ),
            ...buttons.map((item) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AppButtonTheme(
                  data: AppButtonThemeData(
                    style: LeftAlignedAppButton.getStyle(context, size: AppButtonSize.xlarge),
                  ),
                  child: item,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class BottomSheetFunctionFrame extends StatelessWidget {
  const BottomSheetFunctionFrame({
    super.key,
    required this.buttons,
  });

  final List<FunctionButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bottomSheetPadding,
      child: Column(
        children: buttons.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: buttons.last != item ? 16.0 : 0.0),
            child: item,
          );
        }).toList(),
      ),
    );
  }
}

class BottomSheetConfirmFrame extends StatelessWidget {
  const BottomSheetConfirmFrame({
    super.key,
    required this.confirmButton,
    required this.cancelButton,
  });

  final Widget confirmButton;
  final Widget cancelButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bottomSheetPadding,
      child: Column(
        children: [
          AppButtonTheme(
            data: AppButtonThemeData(
              style: context.buttonThemes.alert.outlined.xlarge.copyWith(
                minimumSize: MaterialStatePropertyAll(Size.fromHeight(0.0)),
              ),
            ),
            child: confirmButton,
          ),
          const SizedBox(height: 16.0),
          AppButtonTheme(
            data: AppButtonThemeData(
              style: context.buttonThemes.primary.none.xlarge.copyWith(
                minimumSize: MaterialStatePropertyAll(Size.fromHeight(0.0)),
              ),
            ),
            child: cancelButton,
          ),
        ],
      ),
    );
  }
}

class BottomSheetAgreeTermsFrame extends StatelessWidget {
  const BottomSheetAgreeTermsFrame({
    super.key,
    required this.title,
    required this.agreeAllTile,
    required this.agreeItems,
    required this.leftButton,
    required this.rightButton,
  });

  final Widget title;
  final AgreeTile agreeAllTile;
  final List<AgreeTile> agreeItems;
  final Widget leftButton;
  final Widget rightButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bottomSheetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: context.typography.largeTitle2.emphasized,
            child: title,
          ),
          const SizedBox(height: 16.0),
          agreeAllTile,
          const SizedBox(height: 16.0),
          Divider(),
          const SizedBox(height: 16.0),
          ...agreeItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: item,
            );
          }),
          Row(
            children: [
              Expanded(
                child: AppButtonTheme(
                  data: AppButtonThemeData(style: context.buttonThemes.primary.none.medium),
                  child: leftButton,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: AppButtonTheme(
                  data: AppButtonThemeData(style: context.buttonThemes.primary.filled.medium),
                  child: rightButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetTimePickerFrame extends StatelessWidget {
  const BottomSheetTimePickerFrame({
    super.key,
    this.minutes,
    this.onHourChanged,
    this.onMinuteChanged,
    required this.rightButton,
    this.leftButton,
  });

  final List<int>? minutes;
  final void Function(int hour)? onHourChanged;
  final void Function(int minute)? onMinuteChanged;
  final Widget rightButton;
  final Widget? leftButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bottomSheetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimePicker(
            minutes: minutes,
            onHourChanged: onHourChanged,
            onMinuteChanged: onMinuteChanged,
            size: TimerPickerSize.large,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              if (leftButton != null) ...[
                Expanded(
                  child: AppButtonTheme(
                    data: AppButtonThemeData(
                      style: context.buttonThemes.primary.none.medium,
                    ),
                    child: leftButton!,
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
              Expanded(
                child: AppButtonTheme(
                  data: AppButtonThemeData(
                    style: context.buttonThemes.primary.filled.medium,
                  ),
                  child: rightButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
