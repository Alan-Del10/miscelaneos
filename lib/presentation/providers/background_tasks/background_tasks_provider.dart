import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundFetchsNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgroundFetchsNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  checkCurrentStatus() async {
    state = await SharedPreferencesPlugin.getBool(processKeyName) ?? false;
  }

  activateTask() async {
    //La primera vez es inmediato
    await Workmanager().registerPeriodicTask(
      processKeyName,
      processKeyName,
      frequency: const Duration(seconds: 10), // lo cambiará a 15 minutos
      constraints: Constraints(networkType: NetworkType.connected),
      tag: processKeyName,
    );

    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = true;
  }

  deactivateTask() async {
    if (Platform.isAndroid) {
      await Workmanager().cancelByTag(processKeyName);
    } else {
      await Workmanager().cancelAll();
    }

    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }

  toggleTask() {
    if (state == true) {
      deactivateTask();
    } else {
      activateTask();
    }
  }
}

final backgroundPokemonFetchProvider =
    StateNotifierProvider<BackgroundFetchsNotifier, bool?>((ref) {
      return BackgroundFetchsNotifier(
        processKeyName: fetchPeriodicBackgroudTaskKey,
      );
    });
