import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/idle_detector.dart';

part 'idle_detector_provider.g.dart';

@Riverpod(keepAlive: true)
IdleDetector idleDetector(Ref ref) {
  final detector = IdleDetector();
  detector.start();
  ref.onDispose(detector.dispose);
  return detector;
}

@riverpod
bool isUserIdle(Ref ref) {
  final detector = ref.watch(idleDetectorProvider);
  ref.listen(idleDetectorProvider, (_, _) {});
  return detector.isIdle;
}
