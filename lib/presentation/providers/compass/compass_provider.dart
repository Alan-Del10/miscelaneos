import 'package:compassx/compassx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final compassProvider = StreamProvider<double?>((ref) async* {
  try {
    await for (final event in CompassX.events) {
      yield event.heading;
    }
  } catch (e) {
    throw Exception('Error getting heading $e');
  }
});
