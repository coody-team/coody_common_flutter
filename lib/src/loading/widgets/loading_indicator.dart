import 'package:coody_common_flutter/styles.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.size = const Size(16.0, 16.0),
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CircularProgressIndicator(color: context.colors.gray8),
    );
  }
}
