import 'package:miscelaneos/infrastructure/infrastructure.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroudTaskKey =
    'com.alandelgado.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroudTaskKey =
    'com.alandelgado.miscelaneos.fetch-periodic-background-pokemon';

@pragma(
  'vm:entry-point',
) // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroudTaskKey:
        await loadNextPokemon();
        break;
      case fetchPeriodicBackgroudTaskKey:
        await loadNextPokemon();
        break;
      case Workmanager.iOSBackgroundTask:
        print('Workmanager.iOSBackgroundTask');
      default:
    }

    return true;
  });
}

Future loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonsRepository = PokemonsRepositoryImpl();

  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {
    final (pokemon, message) = await pokemonsRepository.getPokemon(
      '$lastPokemonId',
    );
    if (pokemon == null) throw message;

    await localDbRepository.insertPokemon(pokemon);
    print('pokemon listo ');
  } catch (e) {
    rethrow;
  }
}
