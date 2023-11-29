import 'dart:async';

import 'package:flutter/foundation.dart';

/// Router 새로고침을 Trigger 하는 ChangeNotifier
/// - [Stream]에서 이벤트 발생 시 Trigger
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
