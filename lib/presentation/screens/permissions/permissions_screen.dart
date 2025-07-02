import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permisos')),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionsProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.isCameraGranted,
          title: const Text('Camara'),
          subtitle: Text('${permissions.camera}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.isPhotoLibraryGranted,
          title: const Text('Photos'),
          subtitle: Text('${permissions.photoLibrary}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestPhotosAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.isLocationGranted,
          title: const Text('Location'),
          subtitle: Text('${permissions.location}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.isSensorsGranted,
          title: const Text('Body Sensors'),
          subtitle: Text('${permissions.sensors}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
        ),
      ],
    );
  }
}
