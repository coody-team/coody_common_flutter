import 'dart:async';

abstract interface class OAuthTokenStorage {
  FutureOr<void> write({
    required String key,
    required String? value,
  });

  FutureOr<String?> read({required String key});
}
