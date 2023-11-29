import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class _IEventStreamer<EventType> {
  @mustCallSuper
  void dispose();

  Stream<EventType> get stream;

  StreamController<EventType> get streamController;

  /// 이벤트 구독
  /// - T가 EventType의 SubType인 경우 지정한 이벤트만 구독
  /// - T == EventType인 경우 모든 종류의 이벤트 구독
  StreamSubscription<EventType> on<T extends EventType>(FutureOr Function(T event) handler);

  void emit<T extends EventType>(T event);

  void emitError<T extends EventType>(Object error, [StackTrace? stackTrace]);
}

class _EventStreamer<EventType> implements _IEventStreamer<EventType> {
  _EventStreamer(this._eventController);

  final StreamController<EventType> _eventController;

  @override
  void dispose() {
    _eventController.close();
  }

  @override
  Stream<EventType> get stream => _eventController.stream;

  @override
  StreamController<EventType> get streamController => _eventController;

  @override
  StreamSubscription<EventType> on<T extends EventType>(FutureOr Function(T event) handler) {
    return _eventController.stream.listen((event) async {
      if (event is T) {
        return await handler(event);
      }
    });
  }

  @override
  void emit<T extends EventType>(T event) {
    _eventController.add(event);
  }

  @override
  void emitError<T extends EventType>(Object error, [StackTrace? stackTrace]) {
    _eventController.addError(error, stackTrace);
  }
}

/// Event 발행 및 구독 기능 추가하는 Mixin
mixin EventStreamerMixin<EventType> implements _IEventStreamer<EventType> {
  final _eventStreamer = _EventStreamer(StreamController<EventType>.broadcast());

  @override
  @mustCallSuper
  void dispose() => _eventStreamer.dispose();

  @override
  Stream<EventType> get stream => _eventStreamer.stream;

  @override
  @protected
  StreamController<EventType> get streamController => _eventStreamer.streamController;

  @override
  StreamSubscription<EventType> on<T extends EventType>(FutureOr Function(T event) handler) =>
      _eventStreamer.on(handler);

  @override
  @protected
  void emit<T extends EventType>(T event) => _eventStreamer.emit(event);

  @override
  @protected
  void emitError<T extends EventType>(Object error, [StackTrace? stackTrace]) =>
      _eventStreamer.emitError(error, stackTrace);
}

/// Event 발행 및 구독 기능 추가하는 Mixin
/// - 구독 시 캐시된 가장 최근 이벤트 emit
mixin CachedEventStreamerMixin<EventType> implements _IEventStreamer<EventType> {
  final _eventStreamer = _EventStreamer(BehaviorSubject<EventType>());

  @override
  @mustCallSuper
  void dispose() => _eventStreamer.dispose();

  @override
  Stream<EventType> get stream => _eventStreamer.stream;

  @override
  @protected
  StreamController<EventType> get streamController => _eventStreamer.streamController;

  EventType? get event =>
      (_eventStreamer._eventController as BehaviorSubject<EventType>).valueOrNull;

  @override
  StreamSubscription<EventType> on<T extends EventType>(FutureOr Function(T event) handler) =>
      _eventStreamer.on(handler);

  @override
  @protected
  void emit<T extends EventType>(T event) => _eventStreamer.emit(event);

  @override
  @protected
  void emitError<T extends EventType>(Object error, [StackTrace? stackTrace]) =>
      _eventStreamer.emitError(error, stackTrace);
}
