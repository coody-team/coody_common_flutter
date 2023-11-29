class RefreshTokenState {
  final bool isInitialized;
  final String? refreshToken;

  const RefreshTokenState({
    this.isInitialized = false,
    this.refreshToken,
  });

  @override
  String toString() =>
      'OAuthTokenState(isInitialized: $isInitialized, refreshToken: $refreshToken)';

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RefreshTokenState &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isInitialized, refreshToken);

  // ignore: library_private_types_in_public_api
  _CopyWith get copyWith => _CopyWithImpl(this);
}

abstract interface class _CopyWith {
  RefreshTokenState call({
    bool isInitialized,
    String? refreshToken,
  });
}

class _CopyWithImpl implements _CopyWith {
  final RefreshTokenState _value;

  const _CopyWithImpl(this._value);

  @override
  RefreshTokenState call({
    Object isInitialized = _empty,
    Object? refreshToken = _empty,
  }) {
    return RefreshTokenState(
      isInitialized: isInitialized == _empty ? _value.isInitialized : isInitialized as bool,
      refreshToken: refreshToken == _empty ? _value.refreshToken : refreshToken as String?,
    );
  }
}

class _Empty {
  const _Empty();
}

const _empty = _Empty();
