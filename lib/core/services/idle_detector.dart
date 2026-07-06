import 'dart:async';

import 'package:flutter/services.dart';

/// Tracks user idle state for background batch jobs
/// (docs/05_PROCESSING.md §3.1 — processOnlyWhenIdle).
class IdleDetector {
  IdleDetector({this.idleAfter = const Duration(seconds: 60)});

  final Duration idleAfter;
  DateTime _lastActivity = DateTime.now();
  Timer? _timer;
  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get isIdleStream => _controller.stream;

  bool get isIdle => DateTime.now().difference(_lastActivity) >= idleAfter;

  void start() {
    HardwareKeyboard.instance.addHandler(_onKey);
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _emit());
  }

  void stop() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    _timer?.cancel();
    _timer = null;
  }

  void recordActivity() {
    _lastActivity = DateTime.now();
    _emit();
  }

  bool _onKey(KeyEvent event) {
    recordActivity();
    return false;
  }

  void _emit() => _controller.add(isIdle);

  void dispose() {
    stop();
    _controller.close();
  }
}
