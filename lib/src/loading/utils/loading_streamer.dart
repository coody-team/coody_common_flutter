import 'package:flutter_bloc/flutter_bloc.dart';

abstract interface class LoadingState {
  bool get isLoading;
}

mixin LoadingStreamerMixin<T extends LoadingState> on StateStreamable<T> {
  Stream<bool> get loadingStream => stream.map((event) => event.isLoading);
}
