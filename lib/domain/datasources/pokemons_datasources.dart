import 'package:miscelaneos/domain/domains.dart';

abstract class PokemonsDatasources {
  Future<(Pokemon?, String)> getPokemon(String id);
}
