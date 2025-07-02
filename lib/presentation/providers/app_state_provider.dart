import 'package:flutter/widgets.dart' show AppLifecycleState;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});
