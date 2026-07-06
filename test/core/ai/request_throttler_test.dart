import 'package:flutter_test/flutter_test.dart';
import 'package:logoi/core/ai/errors.dart';
import 'package:logoi/core/ai/guard_limits.dart';
import 'package:logoi/core/ai/request_throttler.dart';

void main() {
  test('circuit breaker blocks burst loop', () {
    final throttler = AIRequestThrottler(
      limits: const AIGuardLimits(
        minSecondsBetweenCalls: 0,
        maxCallsPerMinute: 100,
        circuitBreakerEnabled: true,
      ),
    );

    for (var i = 0; i < 12; i++) {
      throttler.checkAllowed();
      final handle = throttler.acquire(dedupKey: 'k$i');
      handle.release();
    }

    expect(
      () => throttler.checkAllowed(),
      throwsA(isA<ThrottleExceededError>()),
    );
    expect(throttler.isCircuitOpen, isTrue);
  });

  test('dedup in-flight returns same gate', () async {
    final throttler = AIRequestThrottler(
      limits: const AIGuardLimits(minSecondsBetweenCalls: 0),
    );
    throttler.checkAllowed();
    final a = throttler.acquire(dedupKey: 'same');
    final b = throttler.acquire(dedupKey: 'same');
    expect(identical(a.waitIfDuplicate, b.waitIfDuplicate), isFalse);
    a.release();
    b.release();
  });
}
