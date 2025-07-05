import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userLocationProviderAsync = ref.watch(userLocationProvider);
    final watchLocationProviderAsync = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Location Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación actual'),
            userLocationProviderAsync.when(
              data:
                  (data) => Text(
                    '(${data.$1.toStringAsFixed(4)}, ${data.$2.toStringAsFixed(4)})',
                  ),
              error:
                  (error, stackTrace) => Text(
                    'Error: $error',
                    style: TextStyle(color: Colors.red),
                  ),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 30),
            const Text('Seguimiento de ubicación'),
            watchLocationProviderAsync.when(
              data: (data) => Text('$data'),
              error:
                  (error, stackTrace) => Text(
                    'Error: $error',
                    style: TextStyle(color: Colors.red),
                  ),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
