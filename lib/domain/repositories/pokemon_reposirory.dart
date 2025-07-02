import 'package:miscelaneos/domain/domains.dart';

abstract class PokemonsRepository {
  Future<(Pokemon?, String)> getPokemon(String id);
}
