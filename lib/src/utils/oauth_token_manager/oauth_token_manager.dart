library oauth_token_manager;

import 'dart:async';

import 'package:coody_common_flutter/src/utils/oauth_token_manager/interfaces/oauth_token_storage.dart';
import 'package:coody_common_flutter/src/utils/oauth_token_manager/models/oauth_tokens.dart';
import 'package:coody_common_flutter/src/utils/oauth_token_manager/models/refresh_token_state.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

export './interfaces/oauth_token_storage.dart';
export './models/oauth_tokens.dart';
export './models/refresh_token_state.dart';

typedef RefreshCallback = FutureOr<OAuthTokens> Function(String);

class OAuthTokenManager extends ValueNotifier<RefreshTokenState> {
  OAuthTokenManager({
    required this.storage,
    this.storageKey = 'refreshToken',
    required this.refresh,
  }) : super(const RefreshTokenState()) {
    _loadLocalRefreshToken();
  }

  @protected
  final OAuthTokenStorage storage;
  @protected
  final String storageKey;
  @protected
  final RefreshCallback refresh;

  var _accessTokenCompleter = Completer<String?>()..complete(null);

  Future<String?> get accessToken async {
    if (_accessTokenCompleter.isCompleted) {
      final token = await _accessTokenCompleter.future;

      if (_isAccessValid(token)) {
        return token;
      } else {
        final tokens = await refreshTokens();
        return tokens.accessToken;
      }
    } else {
      return await _accessTokenCompleter.future;
    }
  }

  Future<void> setTokens(OAuthTokens value) async {
    if (_accessTokenCompleter.isCompleted) {
      _accessTokenCompleter = Completer()..complete(value.accessToken);
    } else {
      _accessTokenCompleter.complete(value.accessToken);
    }

    this.value = RefreshTokenState(isInitialized: true, refreshToken: value.refreshToken);
    await storage.write(key: storageKey, value: value.refreshToken);
  }

  Future<OAuthTokens> refreshTokens() async {
    try {
      await _loadLocalRefreshToken();
      _accessTokenCompleter = Completer<String?>();

      if (value.refreshToken == null) return const OAuthTokens();

      final tokens = await refresh(value.refreshToken!);
      await setTokens(tokens);

      return tokens;
    } catch (_) {
      await setTokens(const OAuthTokens());
      return const OAuthTokens();
    }
  }

  Future<bool> _loadLocalRefreshToken() async {
    if (value.isInitialized) return value.isInitialized;

    final refreshToken = await storage.read(key: storageKey);

    value = value.copyWith(isInitialized: true);

    if (_isRefreshValid(refreshToken)) {
      value = value.copyWith(refreshToken: refreshToken);
    }

    return value.isInitialized;
  }

  bool _isAccessValid(String? token) {
    return token != null &&
        !JwtDecoder.isExpired(token) &&
        JwtDecoder.getRemainingTime(token) > const Duration(seconds: 30);
  }

  bool _isRefreshValid(String? token) {
    return token != null &&
        !JwtDecoder.isExpired(token) &&
        JwtDecoder.getRemainingTime(token) > const Duration(minutes: 5);
  }
}
