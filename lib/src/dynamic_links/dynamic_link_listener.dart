import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DynamicLinkListener extends StatefulWidget {
  const DynamicLinkListener({
    super.key,
    required this.child,
    required this.goRoute,
    required this.goFallbackRoute,
  });

  final Widget child;
  final void Function(String path) goRoute;
  final void Function() goFallbackRoute;

  @override
  State<DynamicLinkListener> createState() => _DynamicLinkListenerState();
}

class _DynamicLinkListenerState extends State<DynamicLinkListener> {
  @override
  void initState() {
    super.initState();

    _getInitialDynamicLink().then((path) {
      if (path != null) widget.goRoute(path);
    });

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      String toGo = dynamicLinkData.link.toString().replaceFirst(dynamicLinkData.link.origin, '');
      widget.goRoute(toGo);
    }).onError((error) {
      widget.goFallbackRoute();
    });
  }

  Future<String?> _getInitialDynamicLink() async {
    final String? deepLink = await getInitialLink();

    if (deepLink != null) {
      final dynamicLinkData =
          await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(deepLink));

      if (dynamicLinkData != null) {
        return dynamicLinkData.link.toString().replaceFirst(dynamicLinkData.link.origin, '');
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
