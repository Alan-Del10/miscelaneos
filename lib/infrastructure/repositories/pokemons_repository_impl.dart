import 'package:miscelaneos/domain/domains.dart';
import 'package:miscelaneos/infrastructure/datasources/pokemons_datasource_impl.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasources datasource;

  PokemonsRepositoryImpl({PokemonsDatasources? datasource})
    : datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) {
    return datasource.getPokemon(id);
  }
}
