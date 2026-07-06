import 'dart:async';

import 'guard_limits.dart';
import 'errors.dart';

/// In-memory anti-loop throttle checked before every real API call
/// (docs plan §1.1).
class AIRequestThrottler {
  AIRequestThrottler({AIGuardLimits limits = const AIGuardLimits()})
      : _limits = limits;

  AIGuardLimits _limits;
  void updateLimits(AIGuardLimits limits) => _limits = limits;

  static const _circuitBreakerWindow = Duration(seconds: 60);
  static const _circuitBreakerCallThreshold = 12;
  static const _circuitBreakerErrorThreshold = 5;
  static const _circuitBreakerPause = Duration(minutes: 3);

  DateTime? _lastCallAt;
  final _recentCalls = <DateTime>[];
  final _inFlightByKey = <String, Completer<void>>{};
  int _consecutiveErrors = 0;
  DateTime? _circuitOpenUntil;

  bool get isCircuitOpen =>
      _circuitOpenUntil != null && DateTime.now().isBefore(_circuitOpenUntil!);

  Duration? get circuitRemaining =>
      isCircuitOpen ? _circuitOpenUntil!.difference(DateTime.now()) : null;

  /// Throws [ThrottleExceededError] when the call must not proceed.
  void checkAllowed() {
    if (!_limits.circuitBreakerEnabled) return;

    if (isCircuitOpen) {
      throw ThrottleExceededError(
        'Proteção anti-loop ativada. Aguarde '
        '${circuitRemaining!.inSeconds}s.',
        retryAfter: circuitRemaining,
      );
    }

    final now = DateTime.now();
    _pruneRecent(now);

    if (_recentCalls.length >= _circuitBreakerCallThreshold) {
      _openCircuit();
      throw ThrottleExceededError(
        'Proteção anti-loop: muitas chamadas em curto intervalo.',
        retryAfter: _circuitBreakerPause,
      );
    }

    if (_lastCallAt != null) {
      final elapsed = now.difference(_lastCallAt!);
      final minGap =
          Duration(milliseconds: (_limits.minSecondsBetweenCalls * 1000).round());
      if (elapsed < minGap) {
        throw ThrottleExceededError(
          'Aguarde ${(minGap - elapsed).inMilliseconds}ms entre chamadas.',
          retryAfter: minGap - elapsed,
        );
      }
    }

    final minuteAgo = now.subtract(const Duration(minutes: 1));
    final callsLastMinute =
        _recentCalls.where((t) => t.isAfter(minuteAgo)).length;
    if (callsLastMinute >= _limits.maxCallsPerMinute) {
      throw ThrottleExceededError(
        'Limite de ${_limits.maxCallsPerMinute} chamadas/min atingido.',
        retryAfter: const Duration(seconds: 15),
      );
    }

    if (_inFlightByKey.isNotEmpty) {
      throw const ThrottleExceededError(
        'Aguarde a resposta da chamada anterior.',
      );
    }
  }

  /// Registers an in-flight call; returns a release callback.
  ({Future<void> waitIfDuplicate, void Function() release}) acquire({
    required String dedupKey,
  }) {
    final existing = _inFlightByKey[dedupKey];
    if (existing != null) {
      return (
        waitIfDuplicate: existing.future,
        release: () {},
      );
    }

    final gate = Completer<void>();
    _inFlightByKey[dedupKey] = gate;
    final now = DateTime.now();
    _lastCallAt = now;
    _recentCalls.add(now);

    return (
      waitIfDuplicate: Future<void>.value(),
      release: () {
        _inFlightByKey.remove(dedupKey);
        if (!gate.isCompleted) gate.complete();
      },
    );
  }

  void recordSuccess() => _consecutiveErrors = 0;

  void recordError() {
    _consecutiveErrors++;
    if (_limits.circuitBreakerEnabled &&
        _consecutiveErrors >= _circuitBreakerErrorThreshold) {
      _openCircuit();
    }
  }

  void reset() {
    _lastCallAt = null;
    _recentCalls.clear();
    _inFlightByKey.clear();
    _consecutiveErrors = 0;
    _circuitOpenUntil = null;
  }

  void _openCircuit() {
    _circuitOpenUntil = DateTime.now().add(_circuitBreakerPause);
    _consecutiveErrors = 0;
  }

  void _pruneRecent(DateTime now) {
    final cutoff = now.subtract(_circuitBreakerWindow);
    _recentCalls.removeWhere((t) => t.isBefore(cutoff));
  }
}
