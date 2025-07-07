import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userInitialLocationProvider = ref.watch(userLocationProvider);

    return Scaffold(
      body: userInitialLocationProvider.when(
        data:
            (data) => _MapsAndControlls(latitude: data.$1, longitude: data.$2),
        error:
            (error, stackTrace) =>
                Text('Error: $error', style: TextStyle(color: Colors.red)),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}

class _MapsAndControlls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const _MapsAndControlls({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {
    final mapControlledState = ref.watch(mapControlledProvider);

    return Stack(
      children: [
        _MapView(initialLatitude: latitude, initialLongitude: longitude),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControlledProvider.notifier).findUser();
            },
            icon: const Icon(Icons.location_searching),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControlledProvider.notifier).toggleFollowUser();
            },
            icon: Icon(
              mapControlledState.followUser
                  ? Icons.directions_walk_rounded
                  : Icons.accessibility_new,
            ), //Icons.person_pin_circle_rounded
          ),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref
                  .read(mapControlledProvider.notifier)
                  .addMarkerCurrentPosition();
            },
            icon: const Icon(Icons.pin_drop_rounded),
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControlledProvider);

    return GoogleMap(
      markers: mapController.markersSet,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        zoom: 12,
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
      ),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControlledProvider.notifier).setMapController(controller);
      },
      onLongPress:
          (argument) => ref
              .read(mapControlledProvider.notifier)
              .addMarker(argument.latitude, argument.longitude, 'Nuevo'),
    );
  }
}
