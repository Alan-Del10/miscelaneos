import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPosition = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: currentPosition.when(
        data:
            (data) =>
                _MapView(initialLatitude: data.$1, initialLongitude: data.$2),
        error:
            (error, stackTrace) =>
                Text('Error: $error', style: TextStyle(color: Colors.red)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _MapView extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        zoom: 12,
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
      ),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        //_controller.complete(controller);
      },
    );
  }
}
