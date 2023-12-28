import 'package:coody_common_flutter/src/loading/widgets/loading_indicator.dart';
import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum _InputTextSize {
  small,
  large;

  BoxConstraints get inputConstraints => switch (this) {
        small => BoxConstraints(minHeight: 46.0),
        large => BoxConstraints(minHeight: 56.0),
      };

  BoxConstraints get actionButtonConsraints => switch (this) {
        small => BoxConstraints(minHeight: 46.0, maxHeight: 60.0),
        large => BoxConstraints(minHeight: 56.0, maxHeight: 68.0),
      };

  EdgeInsets get inputPadding => switch (this) {
        small => EdgeInsets.symmetric(vertical: 14.0),
        large => EdgeInsets.symmetric(vertical: 18.0),
      };

  TextStyle getTextStyle(BuildContext context) => switch (this) {
        small => context.typography.body2.emphasized,
        large => context.typography.body1.emphasized,
      };
}

class InputText extends StatefulWidget {
  const InputText.small({
    super.key,
    this.title,
    this.helpMessage,
    this.errorMessage,
    this.hintText,
    this.initialText,
    this.maxLength,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
    this.focusNode,
    this.isLoading = false,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSendTap,
    this.onClearTap,
  })  : assert(maxLength == null || maxLength > 0),
        _size = _InputTextSize.small;

  const InputText.large({
    super.key,
    this.title,
    this.helpMessage,
    this.errorMessage,
    this.hintText,
    this.initialText,
    this.maxLength,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
    this.focusNode,
    this.isLoading = false,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSendTap,
    this.onClearTap,
  })  : assert(maxLength == null || maxLength > 0),
        _size = _InputTextSize.large;

  final Widget? title;
  final Widget? helpMessage;
  final Widget? errorMessage;
  final String? hintText;
  final String? initialText;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool isLoading;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final void Function(String text)? onSendTap;
  final void Function()? onClearTap;

  final _InputTextSize _size;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController(text: widget.initialText ?? '');
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  bool get _showFooter =>
      widget.helpMessage != null || widget.errorMessage != null || widget.maxLength != null;

  Widget get _footer {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12.0),
          if (widget.errorMessage != null)
            Expanded(
              child: DefaultTextStyle(
                style: context.typography.caption1.normal.copyWith(color: context.colors.red),
                child: widget.errorMessage!,
              ),
            )
          else if (widget.helpMessage != null)
            Expanded(
              child: DefaultTextStyle(
                style: context.typography.caption1.normal.copyWith(color: context.colors.gray6),
                child: widget.helpMessage!,
              ),
            ),
          if (widget.maxLength != null) ...[
            const SizedBox(width: 4.0),
            ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, child) {
                return Text(
                  '${value.text.length}/${widget.maxLength}',
                  style: context.typography.caption1.normal.copyWith(color: context.colors.gray6),
                );
              },
            ),
          ]
        ],
      ),
    );
  }

  Widget get _sendButton {
    return AppButton(
      style: context.buttonThemes.primary.iconSquare.none.medium,
      onPressed: () => widget.onSendTap?.call(_controller.text),
      child: Icon(
        Symbols.send_rounded,
        fill: 1.0,
      ),
    );
  }

  Widget get _clearButton {
    return AppButton(
      style: context.buttonThemes.primary60.iconCircle.filled.small,
      onPressed: widget.onClearTap,
      child: Icon(Symbols.close_rounded),
    );
  }

  Widget get _actionButton {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      switchInCurve: standardEasing,
      switchOutCurve: standardEasing,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          Widget content = const SizedBox();
          if (widget.isLoading) {
            content = const LoadingIndicator();
          } else if (widget.onSendTap != null) {
            content = _sendButton;
          } else if (widget.onClearTap != null && value.text.isNotEmpty) {
            content = _clearButton;
          }

          return content;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
            child: DefaultTextStyle(
              style: context.typography.title1.normal,
              child: widget.title!,
            ),
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: context.colors.gray2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: widget._size.inputConstraints,
                  child: Center(
                    child: Padding(
                      padding: widget._size.inputPadding,
                      child: TextField(
                        controller: _controller,
                        focusNode: widget.focusNode,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: widget._size.getTextStyle(context).copyWith(
                                color: context.colors.gray5,
                              ),
                          counterText: '',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: widget._size.getTextStyle(context),
                        cursorColor: context.colors.gray8,
                        cursorWidth: 1.0,
                        cursorHeight: 18.0,
                        cursorRadius: Radius.circular(90.0),
                        maxLines: widget.maxLines,
                        maxLength: widget.maxLength,
                        textInputAction: widget.textInputAction,
                        keyboardType: widget.keyboardType,
                        autofocus: widget.autofocus,
                        onChanged: widget.onChanged,
                        onSubmitted: widget.onSubmitted,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4.0),
              ConstrainedBox(
                constraints: widget._size.actionButtonConsraints,
                child: _actionButton,
              ),
            ],
          ),
        ),
        _showFooter ? _footer : const SizedBox(),
      ],
    );
  }
}
