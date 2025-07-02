import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
      return PermissionsNotifier();
    });

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState());

  Future<void> checkPermissions() async {
    final permissionArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionArray[0],
      photoLibrary: permissionArray[1],
      sensors: permissionArray[2],
      location: permissionArray[3],
      locationAlways: permissionArray[4],
      locationWhenInUse: permissionArray[5],
    );
  }

  openSettingsScreen() {
    openAppSettings();
  }

  void _checkPermissionState(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openSettingsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionState(status);
  }

  requestPhotosAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    _checkPermissionState(status);
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _checkPermissionState(status);
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _checkPermissionState(status);
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get isCameraGranted => camera == PermissionStatus.granted;
  get isPhotoLibraryGranted => photoLibrary == PermissionStatus.granted;
  get isSensorsGranted => sensors == PermissionStatus.granted;
  get isLocationGranted => location == PermissionStatus.granted;
  get isLocationAlwaysGranted => locationAlways == PermissionStatus.granted;
  get isLocationWhenInUseGranted =>
      locationWhenInUse == PermissionStatus.granted;

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionsState(
    camera: camera ?? this.camera,
    photoLibrary: photoLibrary ?? this.photoLibrary,
    sensors: sensors ?? this.sensors,
    location: location ?? this.location,
    locationAlways: locationAlways ?? this.locationAlways,
    locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
  );
}
